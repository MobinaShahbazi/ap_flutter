import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/user.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList({Key key}) : super(key: key);
  @override
  State<groupList> createState() => _groupListState();
}


class _groupListState extends State<groupList> {
  Image i=Image.asset('assets/p1.gpj');
  List<group> gList = [
    group("g1", new user("user1", "111"),'assets/p1.jpg'),
    group("g2", new user("user2", "222"),'assets/panda.jpg'),
    group("g3", new user("user3", "333"),'assets/p3.jpg'),
    group("g4", new user("user4", "444"),'assets/messi.jpg'),
    group("g5", new user("user5", "555"),'assets/p2.jpg'),
    group("g6", new user("user6", "666"),'assets/putin.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
      ),

      body: Container(
        child: ListView.builder(
            itemCount: gList.length,
            itemBuilder:  (context,index){
              return groupItem(
                grp: gList[index],
              );
            }
        ),
      ),
    /*
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
      */
    );
  }
}

class groupItem extends StatelessWidget {
  const groupItem({Key key, this.grp}) : super(key: key);
  final group grp;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          //go to detail g
        },
        title: Text(grp.name),
        leading: CircleAvatar(
          backgroundImage: AssetImage(grp.imageURL),
        ),
      ),
    );
  }
}
