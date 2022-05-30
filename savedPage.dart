import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/user.dart';

import 'groupPosts.dart';

class savedPage extends StatefulWidget {
  const savedPage(this.savedPst, this.editGrp, this.saveFromGrp, this.currentUser, this.unSave) ;
  final List<post> savedPst;
  final Function editGrp;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;


  @override
  State<savedPage> createState() => _savedPageState();
}

class _savedPageState extends State<savedPage> {
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
                editGrp: widget.editGrp,
                currentUser: widget.currentUser,
                unSave: widget.unSave,
              );
            }),
      ),
    );
  }
}


class savedItem extends StatefulWidget {
  const savedItem({Key key, this.pst, this.editGrp, this.saveFromGrp, this.currentUser, this.unSave}) : super(key: key);
  final post pst;
  final Function editGrp;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.editGrp,widget.currentUser,widget.saveFromGrp,widget.unSave))
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
            child: Row(
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

          )



        ],
      ),
    );
  }
}
