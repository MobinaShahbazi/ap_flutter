import 'package:redit/group.dart';
import 'package:redit/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:intl/intl.dart';
import 'commentPart.dart';

class postDetails extends StatefulWidget {
  const postDetails(this.pst,this.grp);
  final post pst;
  final group grp;
  @override
  State<postDetails> createState() => _postDetailsState();
}

class _postDetailsState extends State<postDetails> {
  TextEditingController com=TextEditingController();
  void addComment(comment cm){
    setState(() {
      widget.pst.comments.add(cm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Column(children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Text(
                  widget.grp.name ,
                ),
              ),
            ),
            GestureDetector(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: Text(
                        widget.pst.userPublisher.userName+':', style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        child: Text(
                            (DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date)),style: TextStyle(fontSize: 15))
                    ),
                  ),
                ],
              ),
            ),
          ]),
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.grp.imageURL),
          ),
        ),
        body:Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment(-.9, 0),
                      child: Text(widget.pst.title, style: TextStyle(fontSize: 25)),
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
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child:  TextButton.icon(
                            onPressed: (){
                            },
                            icon: Icon(Icons.comment_outlined, size: 20, color: Colors.white,
                            ),
                            label: Text(widget.pst.comments.length.toString()),
                          ),
                        ),
                        Container(
                          child:  TextButton.icon(
                              icon: Icon(Icons.thumb_up_alt_outlined, size: 20, color: Colors.white,
                              ),
                              label: Text(widget.pst.likesNum.toString()),
                              onPressed: () {}),
                        ),
                        Container(
                          child:  TextButton.icon(
                              icon: Icon(Icons.thumb_down_alt_outlined, size: 20, color: Colors.white,
                              ),
                              label: Text(widget.pst.disLikesNum.toString()),
                              onPressed:(){}),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.pst.comments.length,
                        itemBuilder:  (context,index){
                          return commentItem(
                            cmnt: widget.pst.comments[index],
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
            decoration:  InputDecoration(hintText: 'new comment',  suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed:(){setState(() {
                comment cm=comment(new user("u1", "111"),com.text);
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
