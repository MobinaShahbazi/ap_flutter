import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class commentItem extends StatefulWidget {
  const commentItem({Key key, this.cmnt}) : super(key: key);
  final comment cmnt;

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
                    like();},
                  icon: Icon(likeUser?Icons.thumb_up:Icons.thumb_up_alt_outlined,size:16,color: Colors.white),
                  label: Text(widget.cmnt.likesNum.toString(),style: TextStyle(color: Colors.white70)),
                ),
                TextButton.icon(
                  onPressed:(){setState(() {
                    disLikeUser = !disLikeUser;});unlike();},
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
