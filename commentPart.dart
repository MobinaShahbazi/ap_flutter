import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

class commentList extends StatefulWidget {
  const commentList({Key key}) : super(key: key);

  @override
  State<commentList> createState() => _commentListState();
}

class _commentListState extends State<commentList> {
  List<comment> cList=[
    comment(new user("u1", "111"),"bah bah1"),
    comment(new user("u2", "222"),"bah bah2"),
    comment(new user("u2", "333"),"bah bah3"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: cList.length,
            itemBuilder:  (context,index){
              return commentItem(
                cmnt: cList[index],
              );
            }
        ),
      ),
    );
  }
}
class commentItem extends StatelessWidget {
  const commentItem({Key key, this.cmnt}) : super(key: key);
  final comment cmnt;

  @override
  Widget build(BuildContext context) { ///how to show comment?
    return Container(
      child: ListTile(
        onTap: (){
          //go to detail g
        },
        title: Text(cmnt.content),
      ),
    );
  }
}

