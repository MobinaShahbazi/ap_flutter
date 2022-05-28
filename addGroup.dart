import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

import 'group.dart';

class addGroup extends StatefulWidget {
  const addGroup(this.addGrp);
  final Function addGrp;

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
                  String name=nameC.text;
                  group newGroup=group(name, user("newUser","sS777777"), "assets/newg.jpg", []);
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
