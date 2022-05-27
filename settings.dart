import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addGroup.dart';
import 'package:redit/post.dart';
import 'package:redit/savedPage.dart';

class settings extends StatefulWidget {
  const settings(this.addGrp, this.savedPst, ) ;
  final Function addGrp;
  final List<post> savedPst;

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
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
                    title:  Text('Mobina Shahbazi',style: TextStyle(fontSize: 23),) ,
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
                          MaterialPageRoute(builder: (context) => savedPage(widget.savedPst))
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
