import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/editPost.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/user.dart';
import 'editGroup.dart';


class groupPosts extends StatefulWidget {
  const groupPosts(this.grp, this.editGrp, this.currentUser, this.saveFromGrp, this.unSaveFromGrp);
  final group grp;
  final Function editGrp;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSaveFromGrp;


  @override
  State<groupPosts> createState() => _groupPostsState();
}

class _groupPostsState extends State<groupPosts> {

  void removePstGrp(int index){
    setState(() {
      widget.grp.posts.remove(widget.grp.posts[index]);
    });
  }
  void addPst(post p){
    setState(() {
      widget.grp.posts.add(p);
    });
  }
  String groupName='';
  @override
  void initState() {
    groupName=widget.grp.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.grp.imageURL),
        ),
        title: Text(widget.grp.name, style: TextStyle(fontSize: 20,),),
        actions: [IconButton(
            onPressed: (){
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => editGroup(widget.grp,widget.editGrp))
                );
              });
            },
            icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.grp.posts.length,
            itemBuilder: (contex, index) {
              return postItem(
                pst: widget.grp.posts[index],
                grp: widget.grp,
                removePst: ()=> removePstGrp(index),
                //savedPost: widget.savedPost,
                currentUser: widget.currentUser,
                saveFromGrp: widget.saveFromGrp,
                unSaveFromGrp: widget.unSaveFromGrp,

              );
            }),
      ),

    );
  }
}

class postItem extends StatefulWidget {
  const postItem({Key key, this.pst, this.grp, this.removePst, this.currentUser, this.saveFromGrp, this.unSaveFromGrp,}) : super(key: key);
  final post pst;
  final group grp;
  final Function removePst;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final user currentUser;
  @override
  State<postItem> createState() => _postItemState();
}

class _postItemState extends State<postItem> {
  static const snackBar = SnackBar(content: Text('Access denied'),);

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
  bool isEqual(user u1,user u2){
    if(u1.userName == u2.userName && u1.password==u2.password)
      return true;
    else
      return false;
  }
  bool isSaved=false;
  @override
  Widget build(BuildContext context) {
    int vote=0;
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                heightFactor: 1.7,
                alignment: Alignment(-.9, 0),
                child: Text(widget.pst.title, style: TextStyle(fontSize: 25)),
              ),
              Positioned(
                  right: -5,
                  child: Container(child: IconButton(icon: Icon(Icons.edit, size: 16,),
                    //if usere
                    onPressed: () {
                      if(isEqual(widget.currentUser, widget.grp.admin)) {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => editPost(widget.pst))
                          );
                        });
                      }
                      else
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  )),
              Positioned(
                  right: 25,
                  child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                    //if usere
                    onPressed: () {
                      if(isEqual(widget.currentUser, widget.grp.admin))
                        widget.removePst();
                      else
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  )),
            ],
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
                      child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.grp,widget.currentUser,isLiked,isDisliked)));
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(isSaved? Icons.save:Icons.save_outlined, size: 20,),
                        onPressed: (){
                        setState(() {
                          isSaved=!isSaved;
                        });
                        if(isSaved){
                          widget.saveFromGrp(widget.pst,widget.grp);
                        }
                        else{
                          widget.unSaveFromGrp(widget.pst,widget.grp);
                        }

                        },
                      ),
                    )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

