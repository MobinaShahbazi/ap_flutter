import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class addPost extends StatefulWidget {
  const addPost(this.addNewPst);
  final Function addNewPst;

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  TextEditingController titleC;
  TextEditingController captionC;
  @override
  void initState() {
    titleC=TextEditingController();//captionC
    captionC=TextEditingController();//captionC
    super.initState();
  }

  @override
  void dispose() {
    titleC.dispose();
    captionC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.deepOrange.shade200,
              decoration: const InputDecoration(hintText: "Title"),
              controller: titleC,
              keyboardType: TextInputType.text,
            ),
            TextField(
              cursorColor: Colors.deepOrange.shade200,
              decoration: const InputDecoration(hintText: "Caption"),
              controller: captionC,
              keyboardType: TextInputType.text,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
              width: 200,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange.shade200,onPrimary: Colors.black),
                onPressed: (){
                  String title =titleC.text;
                  String caption =captionC.text;
                  post p=post(title,caption,'assets/newpost.jpg');
                  widget.addNewPst(p);
                  titleC.clear();
                  captionC.clear();
                  Navigator.pop(context);
                  //widget.sort();
                },
                child: Text('Add new post',style: TextStyle(fontSize: 17),),
              )
            )
          ],
        ),
      ),
    );
  }
}
