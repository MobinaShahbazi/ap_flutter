import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class editGroup extends StatefulWidget {
  const editGroup(this.grp, this.editGrp, this.indexOfEdit, this.allPosts, this.editGrpFromFeed) ;
  final group grp;
  final Function editGrp;
  final Function editGrpFromFeed;
  final int indexOfEdit;
  final List<post> allPosts;

  @override
  State<editGroup> createState() => _editGroupState();
}

class _editGroupState extends State<editGroup> {
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
  int findIndex(group g){
    int index=0;
    for(int i=0;i<widget.allPosts.length;i++){
      print(g.name);
      print(widget.allPosts[i].groupPublisher.name);
      if(g.name==widget.allPosts[i].groupPublisher.name){
        index=i;
      }
    }
    return index;
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
              decoration: const InputDecoration(hintText: "New Group Name"),
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
                    setState(() {
                      widget.editGrpFromFeed(findIndex(widget.grp),name);
                      widget.editGrp(widget.indexOfEdit,name);
                    });
                    nameC.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Confirm',style: TextStyle(fontSize: 17),),
                )
            )
          ],
        ),
      ),
    );
  }
}
