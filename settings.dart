import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addGroup.dart';
import 'package:redit/editUser.dart';
import 'package:redit/post.dart';
import 'package:redit/savedPage.dart';
import 'package:redit/user.dart';

import 'aboutUs.dart';

class settings extends StatefulWidget {
  const settings(this.addGrp, this.savedPst, this.currentUser, this.users,this.saveFromGrp, this.unSaveFromGrp, this.setCurrentUser, this.removePstFeed, this.allPosts, ) ;
  final Function addGrp;
  final List<post> savedPst;
  final List<post> allPosts;
  final user currentUser;
  final List<user> users;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function setCurrentUser;
  final Function removePstFeed;


  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  String u,p,e;
  List<user> cUser=[];
  @override
  void initState() {
    u=widget.currentUser.userName;
    p=widget.currentUser.password;
    e=widget.currentUser.email;
    cUser.insert(0, user(u,p,e));
    super.initState();
  }
  void changeUser(int index,String u,String p,String e){
    setState(() {
      cUser[index].setUserName(u);
      cUser[index].setPassword(p);
      cUser[index].setEmail(e);
      widget.setCurrentUser(u,p,e);
      print(widget.currentUser.userName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body:Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15,bottom: 10,left: 0,right: 10),
                  child:ListTile(
                    title:  Text(cUser[0].userName,style: TextStyle(fontSize: 23),) ,
                    leading: CircleAvatar(
                      radius: 33,
                      backgroundImage: AssetImage('assets/empty1.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                    top: 17,
                    child: IconButton(
                      onPressed: (){
                        print(widget.currentUser.email);
                        print(widget.currentUser.userName);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => editUser(widget.currentUser,widget.users,widget.addGrp,widget.savedPst,widget.saveFromGrp,widget.unSaveFromGrp,widget.setCurrentUser,changeUser))//////////////////////
                        );
                      },
                    icon: Icon(Icons.edit,size: 20,)
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => addGroup(widget.addGrp))//////////////////////
                        );
                  },
                      icon: Icon(Icons.add,color: Colors.deepOrange.shade200,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
                    child: Text('Add a new group',style: TextStyle(fontSize: 17),),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => savedPage(widget.savedPst,widget.saveFromGrp,widget.currentUser,widget.unSaveFromGrp,widget.removePstFeed,widget.allPosts))
                      );

                    },
                    icon: Icon(Icons.save_outlined,color: Colors.deepOrange.shade200,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
                    child: Text('View saved posts',style: TextStyle(fontSize: 17),),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => aboutUs())
                      );
                    },
                    icon: Icon(Icons.info_outline,color: Colors.deepOrange.shade200,),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
                    child: Text('More information',style: TextStyle(fontSize: 17),),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
