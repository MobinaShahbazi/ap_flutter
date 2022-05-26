import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({Key key}) : super(key: key);

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
            Container(
              
                    height: 100,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: ListTile(
                        title:  Text('Mobina Shahbazi',style: TextStyle(fontSize: 23),) ,
                        leading: CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/empty1.jpg'),
                        ),
                      ),

            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed:(){

                  },
                      icon: Icon(Icons.add),
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

                    },
                    icon: Icon(Icons.save_outlined),
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
                    icon: Icon(Icons.info_outline),
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
