
import 'package:redit/group.dart';
import 'package:redit/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:intl/intl.dart';
import 'commentPart.dart';

class postDetails extends StatefulWidget {
  const postDetails(this.pst,this.grp, this.currentUser, this.isLiked, this.isDisliked, this.comments);
  final post pst;
  final group grp;
  final user currentUser;
  final bool isLiked;
  final bool isDisliked;
  final List<comment> comments;
  @override
  State<postDetails> createState() => _postDetailsState();
}

class _postDetailsState extends State<postDetails> {
  TextEditingController com=TextEditingController();
  void addComment(comment cm){
    setState(() {
      widget.comments.add(cm);
    });
  }
  bool isL=false;
  bool isD=false;
  @override
  void initState() {
    isL=widget.isLiked?true:false;
    isD=widget.isDisliked?true:false;
    super.initState();
  }

  void like(){
    if(!isL) {
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
      if(isD) {
        int num = widget.pst.disLikesNum;
        num--;
        setState(() {
          widget.pst.setDislikesNum(num);
        });
        isD=!isD;
      }
    }
  }
  void dislike(){
    if(!isD) {
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
      if(isL) {
        int num = widget.pst.likesNum;
        num--;
        setState(() {
          widget.pst.setlikesNum(num);
        });
        isL=!isL;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Comments'),
        ),
        body:Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.grp.name),
                    subtitle: Text( widget.pst.userPublisher.userName+' / '+ DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date), style: TextStyle(fontSize: 15)),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(widget.grp.imageURL),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment(-.85, 0),
                      child: Text(widget.pst.title, style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.pst.caption,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child:  TextButton.icon(
                            icon: Icon(Icons.comment_outlined, size: 20, color: Colors.white,
                            ),
                            label: Text(widget.pst.commentsNum.toString(),style: TextStyle(color: Colors.white70),),
                          ),
                        ),
                        Container(
                          child:  TextButton.icon(
                              icon: Icon(isL?Icons.thumb_up:Icons.thumb_up_alt_outlined, size: 20, color: Colors.white,
                              ),
                              label: Text(widget.pst.likesNum.toString(),style: TextStyle(color: Colors.white70)),
                              ),
                        ),
                        Container(
                          child:  TextButton.icon(
                              icon: Icon(isD?Icons.thumb_down:Icons.thumb_down_alt_outlined,size: 20, color: Colors.white,
                              ),
                              label: Text(widget.pst.disLikesNum.toString(),style: TextStyle(color: Colors.white70)),

                              ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.comments.length,/////////////////////
                        itemBuilder:  (context,index){
                          return commentItem(
                            cmnt: widget.comments[index],//////////////////////
                          );
                        }
                    ),
                  ),
                ],
              ),
            )
        ),
        bottomSheet:Container(
          child:TextField(
            controller: com,
            decoration:  InputDecoration(hintText: 'Add a comment',  suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed:(){setState(() {
                comment cm=comment(new user(widget.currentUser.userName),com.text,0,0);
                addComment(cm);
                com.clear();
              });},
            ) , border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
          ) ,
        )
    );
  }
}
