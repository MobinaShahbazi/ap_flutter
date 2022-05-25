import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList({Key key}) : super(key: key);
  @override
  State<groupList> createState() => _groupListState();
}


class _groupListState extends State<groupList> {

  List<post> savedPosts=[

  ];
  List<group> gList = [
    group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg', [
      post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
          "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg", ),
      post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
          "together to uncover a conspiracy.", "assets/anim/zoo.jpg", ),
      post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
          "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", ),
      post("Encanto", "A Colombian teenage girl has to face the frustration of being the only member of her "
          "family without magical powers.", "assets/anim/enc.jpg", ),
      post("Wish Dragon", "Determined teen Din is longing to reconnect with his childhood best friend when he meets a wish-granting"
            " dragon who shows him the magic of possibilities.", "assets/anim/wish.jpg", )
  ]
    ),

    group("Tourism", new user("user2", "Ba222222"),'assets/tourism/traveller.jpg',[
      post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
          " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg', ),
      post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
          " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg', ),
      post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
          "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", ),
      post("Pisa Tower", "TheLeaning Tower of Pisa is one of the most remarkable architectural structures from medieval Europe. "
          "It is located in the Italian town of Pisa, one of the most visited European cities.", 'assets/tourism/italy.jpg', ),
      post("China Wall", "The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection "
          "against various nomadic groups from the Eurasian Steppe.", 'assets/tourism/china.jpg', ),
    ]
    ),

    //group("g3", new user("user3", "333"),'assets/p3.jpg'),
    //group("g4", new user("user4", "444"),'assets/messi.jpg'),
    //group("g5", new user("user5", "555"),'assets/p2.jpg'),
    //group("g6", new user("user6", "666"),'assets/putin.jpg'),

  ];
  void addGrp(group g){
    setState(() {
      gList.add(g);
    });
  }



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
                saved: savedPosts,
              );
            }
        ),
      ),
        bottomNavigationBar: Container(
          child: Row(
            children: [
              /*
              IconButton(
                 onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  feed)
                  },
                  icon: Icon(Icons.home)
                  )
               */
            ],
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
  const groupItem({Key key, this.grp, this.saved}) : super(key: key);
  final group grp;
  final List<post> saved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  groupPosts(grp,saved))
          );
          //go to groupPosts
        },
        title: Text(grp.name),
        leading: CircleAvatar(
          backgroundImage: AssetImage(grp.imageURL),
        ),
      ),
    );
  }
}
