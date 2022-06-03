import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/user.dart';
import 'groupPosts.dart';

class savedPage extends StatefulWidget {
  const savedPage(this.savedPst, this.saveFromGrp, this.currentUser, this.unSave, this.removePstFeed, this.allPosts) ;
  final List<post> savedPst;
  final List<post> allPosts;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;
  final Function removePstFeed;
  

  @override
  State<savedPage> createState() => _savedPageState();
}

class _savedPageState extends State<savedPage> {
  @override
  void initState() {
    sortSaved();
    super.initState();
  }
  void unSave(int index){
    setState(() {
      widget.savedPst.remove(widget.savedPst[index]);
    });
  }
  void sortSaved(){
    final DateFormat formatter = DateFormat('yyyyMMdd');
    for(int i=0;i<widget.savedPst.length-1;i++){
      for(int j=0;j<widget.savedPst.length-1-i;j++) {
        if(int.parse(formatter.format(widget.savedPst[j].date)) < int.parse(formatter.format(widget.savedPst[j+1].date))){
          setState( () {
            post p=widget.savedPst[j];
            widget.savedPst[j]=widget.savedPst[j+1];
            widget.savedPst[j+1]=p;
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.savedPst.length,
            itemBuilder: (contex, index) {
              return savedItem(
                pst: widget.savedPst[index],
                saveFromGrp: widget.saveFromGrp,
                currentUser: widget.currentUser,
                unSave:()=> unSave(index),
                savedPst: widget.savedPst,
                removePstFeed: widget.removePstFeed,
                allPosts: widget.allPosts,
              );
            }),
      ),
    );
  }
}


class savedItem extends StatefulWidget {
  const savedItem({Key key, this.pst, this.saveFromGrp, this.currentUser, this.unSave, this.savedPst, this.removePstFeed, this.allPosts}) : super(key: key);
  final post pst;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;
  final List<post> savedPst;
  final List<post> allPosts;
  final Function removePstFeed;


  @override
  State<savedItem> createState() => _savedItemState();
}

class _savedItemState extends State<savedItem> {
  bool isLiked=false;
  bool isDisliked=false;
  void like(){
    if(!isLiked) {
      int num = widget.pst.likesNum;
      num--;
      setState(() {
        widget.pst.setlikesNum(num);
      });
    }
    else {
      int num = widget.pst.likesNum;
      num++;
      setState(() {
        widget.pst.setlikesNum(num);
      });
      if(isDisliked) {
        int num = widget.pst.disLikesNum;
        num--;
        setState(() {
          widget.pst.setDislikesNum(num);
        });
        isDisliked=!isDisliked;
      }
    }
  }
  void dislike(){
    if(!isDisliked) {
      int num = widget.pst.disLikesNum;
      num--;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
    }
    else {
      int num = widget.pst.disLikesNum;
      num++;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
      if(isLiked) {
        int num = widget.pst.likesNum;
        num--;
        setState(() {
          widget.pst.setlikesNum(num);
        });
        isLiked=!isLiked;
      }
    }
  }
  void unSave(post p){
      widget.savedPst.remove(p);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.currentUser,widget.saveFromGrp,widget.unSave,widget.savedPst,widget.removePstFeed,widget.allPosts))
              );

            },
            title: Text(widget.pst.groupPublisher.name,style: TextStyle(fontSize: 22),),
            leading: CircleAvatar(backgroundImage: AssetImage(widget.pst.groupPublisher.imageURL),
            ),
          ),
          Container(
            child:  Align(
              heightFactor: 1.7,
              alignment: Alignment(-.9, 0),
              child: Text(widget.pst.title, style: TextStyle(fontSize: 19,color: Colors.white70)),
            ),
          ),
          Align(
            //heightFactor: 1.7,
              alignment: Alignment(-.9,0),
              child:  Text((DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date)),style: TextStyle(fontSize: 15,color: Colors.white70))
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(widget.pst.imageURL),
                )),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.pst.caption,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
          Container(
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      child: IconButton(icon: Icon(isLiked ?Icons.thumb_up:Icons.thumb_up_alt_outlined , size: 20,),
                        onPressed: () {
                          setState(() {
                            isLiked = ! isLiked;
                          });
                          like();
                        },
                      ),
                    ),
                    Container(
                      child: Text('${widget.pst.likesNum - widget.pst.disLikesNum }'),
                    ),
                    Container(
                      child: IconButton(icon: Icon(isDisliked?Icons.thumb_down:Icons.thumb_down_alt_outlined, size: 20,),
                          onPressed: () {
                            setState(() {
                              isDisliked = ! isDisliked;
                            });
                            dislike();
                          }),
                    ),
                    Container(
                      child: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.pst.groupPublisher,widget.currentUser,isLiked,isDisliked)));
                          },
                          icon: Icon(Icons.comment_outlined, size: 20,)

                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(Icons.save, size: 20,),
                        onPressed: (){
                        setState(() {
                          widget.unSave();
                        });
                        },
                      ),
                    ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
