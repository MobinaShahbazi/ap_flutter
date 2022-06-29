import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

class addPost extends StatefulWidget {
  const addPost(this.addNewPst, this.currentUser, this.grp, this.sortFeed);
  final group grp;
  final Function addNewPst;
  final user currentUser;
  final Function sortFeed;


  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  static const snackBar1 = SnackBar(content: Text('Title can not be empty',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);
  static const snackBar2 = SnackBar(content: Text('Caption can not be empty',style: TextStyle(fontSize: 16)),backgroundColor: (Colors.grey),);
  bool isActive=false;
  TextEditingController titleC;
  TextEditingController captionC;
  @override
  void initState() {
    titleC=TextEditingController();
    captionC=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleC.dispose();
    captionC.dispose();
    super.dispose();
  }
  void add(){
  }
  sendNewPost(String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike,String comment) async {
    print("sendingggg");
    String request="addPost\ngroupImage:$groupImage,,like:$like,,dislike:$dislike,,comment:$comment,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user,,groupName:$groupName,,groupAdmin:$groupAdmin\u0000";
    print("rrr: $request");
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
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
                  if(titleC.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                  }
                  if(captionC.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                  }
                  if(!titleC.text.isEmpty && !captionC.text.isEmpty)
                  {
                  setState(()=> isActive=false );
                  sendNewPost(titleC.text, captionC.text, "assets/newpost.jpg", DateTime.now().toString(), widget.currentUser.userName, widget.grp.name, widget.grp.admin.userName, widget.grp.imageURL,"0","0","0");
                  post p=post(titleC.text,captionC.text,'assets/newpost.jpg',DateTime.now(),widget.currentUser,[],widget.grp,0,0,0);
                  widget.addNewPst(p,widget.grp);
                  titleC.clear();
                  captionC.clear();
                  setState(() {
                    widget.sortFeed();
                  });
                  Navigator.pop(context);
                 }
                  else{
                    null;
                  }
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
