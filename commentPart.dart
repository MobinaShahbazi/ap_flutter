import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class commentItem extends StatefulWidget {
  const commentItem({Key key, this.cmnt, this.pst}) : super(key: key);
  final comment cmnt;
  final post pst;

  @override
  State<commentItem> createState() => _commentItemState();
}

class _commentItemState extends State<commentItem> {
  bool likeUser=false;
  bool disLikeUser=false;
  void like(){
    if(!likeUser) {
      int num = widget.cmnt.likesNum;
      num--;
      setState(() {
        widget.cmnt.setLikesNum(num);
      });
    }
    else {
      int num = widget.cmnt.likesNum;
      num++;
      setState(() {
        widget.cmnt.setLikesNum(num);
      });
        if(disLikeUser) {
          int num = widget.cmnt.disLikesNum;
          num--;
          setState(() {
            widget.cmnt.setDislikesNum(num);
          });
          disLikeUser=!disLikeUser;
        }
    }
  }
  void unlike(){
    if(!disLikeUser) {
      int num = widget.cmnt.disLikesNum;
      num--;
      setState(() {
        widget.cmnt.setDislikesNum(num);
      });
    }
    else {
      int num = widget.cmnt.disLikesNum;
      num++;
      setState(() {
        widget.cmnt.setDislikesNum(num);
      });
      if(likeUser) {
        int num = widget.cmnt.likesNum;
        num--;
        setState(() {
          widget.cmnt.setLikesNum(num);
        });
        likeUser=!likeUser;
      }
    }
  }
  resetComment(String title, String user, String content, String like, String dislike) async {
    print ("to func1: ");
    String request="likeDislikeComment\nlike:$like,,dislike:$dislike,,title:$title,,user:$user,,content:$content\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  @override
  Widget build(BuildContext context) { ///how to show comment?
    return Container(
      child: ListTile(

        title: Text(widget.cmnt.commentOwner.userName+' :  '+widget.cmnt.content),
        trailing: GestureDetector(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children:<Widget> [
                TextButton.icon(
                  onPressed: (){ setState(() {
                    likeUser = !likeUser;
                  });
                    like();
                  resetComment(widget.pst.title,widget.cmnt.commentOwner.userName,widget.cmnt.content,widget.cmnt.likesNum.toString(),widget.cmnt.disLikesNum.toString());
                    },
                  icon: Icon(likeUser?Icons.thumb_up:Icons.thumb_up_alt_outlined,size:16,color: Colors.white),
                  label: Text(widget.cmnt.likesNum.toString(),style: TextStyle(color: Colors.white70)),
                ),
                TextButton.icon(
                  onPressed:(){setState(() {
                    disLikeUser = !disLikeUser;
                  });
                    unlike();
                  resetComment(widget.pst.title,widget.cmnt.commentOwner.userName,widget.cmnt.content,widget.cmnt.likesNum.toString(),widget.cmnt.disLikesNum.toString());
                  },
                  icon: Icon(disLikeUser?Icons.thumb_down:Icons.thumb_down_alt_outlined,size: 16,color: Colors.white),
                  label: Text(widget.cmnt.disLikesNum.toString(),style: TextStyle(color: Colors.white70)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
