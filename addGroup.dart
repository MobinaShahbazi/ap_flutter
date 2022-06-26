import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

import 'group.dart';

class addGroup extends StatefulWidget {
  const addGroup(this.addGrp, this.currentUser);
  final Function addGrp;
  final user currentUser;

  @override
  State<addGroup> createState() => _addGroupState();
}

class _addGroupState extends State<addGroup> {
  TextEditingController nameC;
  @override
  void initState() {
    nameC=TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    nameC.dispose();
    super.dispose();
  }
  sendNewGrp(String name, String user, String image, String fav)async{
    print("get called");
    String request="addGroup\nname:$name,,user:$user,,image:$image,,fav:$fav\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
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
        title: Text("Reddit"),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.deepOrange.shade200,
              decoration: const InputDecoration(hintText: "Group Name"),
              controller: nameC,
              keyboardType:  TextInputType.text,
            ),
            Container(
              color: Colors.deepOrange.shade200,
              margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
              width: 200,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange.shade200,onPrimary: Colors.black),
                onPressed: (){
                  // sendNewGrp(String name, String user, String image, String fav);
                  String name=nameC.text;
                  group newGroup=group(name, widget.currentUser, "assets/newg.jpg", [],false);
                  widget.addGrp(newGroup);
                  nameC.clear();
                  Navigator.pop(context);
                },
                child: Text('Add new group',style: TextStyle(fontSize: 17),),
            )
            )
          ],
        ),
      ),
    );
  }
}
