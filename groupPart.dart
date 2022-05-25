import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';
import 'feed.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList({Key key}) : super(key: key);
  @override
  State<groupList> createState() => _groupListState();
}


class _groupListState extends State<groupList> {

  List<post> savedPosts=[];
  List<post> allPosts=[
    post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
        "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
        [
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
    )),

    post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
        " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',group("Tourism", new user("user2", "Ba222222"),'assets/tourism/traveller.jpg',
        [
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
  ),),
    post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
        "together to uncover a conspiracy.", "assets/anim/zoo.jpg",group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
        [
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
    )),




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
    group("Novel Novels", new user("user3", "333"),'assets/books/prof.jpg',[]),
    group("Best_Painters", new user("user4", "444"),'assets/art/p3.jpg',[]),
    group("Soccer", new user("user6", "666"),'assets/football/messi.jpg',[]),
    group("Cookery", new user("user5", "555"),'assets/food/pizza.jpg',[]),
    group("Luxury Car2022", new user("user5", "555"),'assets/car/Lambor.jpg',[]),
    group("Animal Photography", new user("user5", "555"),'assets/animals/panda.jpg',[]),
    group("Moder Architecture", new user("user5", "555"),'assets/archi/p3.jpg',[]),
    group("Digimoviez", new user("user5", "555"),'assets/movies/WorldWarZ.jpg',[]),
    group("News", new user("user5", "555"),'assets/news/p1.jpg',[]),
    group("Amazing ", new user("user5", "555"),'assets/Nature/Italy.jpg',[]),

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
              Container(
                width: 90,
                child: IconButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => feed(allPosts,savedPosts))//////////////////////
                      );
                    },
                    icon: Icon(Icons.settings)
                ),
              ),
              Container(
                width: 100,
                child: IconButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => feed(allPosts,savedPosts))/////////////////
                      );
                    },
                    icon: Icon(Icons.add)
                ),
              ),
              Container(
                width: 100,
                child: IconButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => feed(allPosts,savedPosts))///////////////////////////
                      );
                    },
                    icon: Icon(Icons.list_outlined)
                ),
              ),
              Container(
                  width: 90,
                  child: IconButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => feed(allPosts,savedPosts))/////////////////////
                      );
                    },
                    icon: Icon(Icons.home)
                )
              ),
            ],
          ),
        ),
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
