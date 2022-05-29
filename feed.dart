import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addGroup.dart';
import 'package:redit/addPost.dart';
import 'package:redit/editGroup.dart';
import 'package:redit/groupPart.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/settings.dart';
import 'package:redit/user.dart';

import 'editPost.dart';
import 'group.dart';
import 'groupPosts.dart';

class feed extends StatefulWidget {
  const feed(this.currentUser, this.users );
  final user currentUser;
  final List<user> users;
  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  List<post> savedPosts=[];
  List<post> allPosts=[
    post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
        "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2021-11-10'),user('mbn','123'),group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
        [
          post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
              "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2021-01-10'),user('zrh','11') ),
          post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
              "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123') ),
          post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
              "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717')),
          post("Encanto", "A Colombian teenage girl has to face the frustration of being the only member of her "
              "family without magical powers.", "assets/anim/enc.jpg",DateTime.parse('2022-05-23'),user('mbn','123') ),
          post("Wish Dragon", "Determined teen Din is longing to reconnect with his childhood best friend when he meets a wish-granting"
              " dragon who shows him the magic of possibilities.", "assets/anim/wish.jpg",DateTime.parse('2020-10-10'),user('mds','1717') )
        ]
    )),

    post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
        " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('',''),group("Tourism", new user("user2", "Ba222222"),'assets/tourism/traveller.jpg',
        [
          post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
              " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('ali','12') ),
          post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
              " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2014-12-10'),user('mmd','400') ),
          post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
              "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2019-03-16'),user('mbn','123')),
          post("Pisa Tower", "TheLeaning Tower of Pisa is one of the most remarkable architectural structures from medieval Europe. "
              "It is located in the Italian town of Pisa, one of the most visited European cities.", 'assets/tourism/italy.jpg', DateTime.parse('1999-11-10'),user('mmd','400')),
          post("China Wall", "The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection "
              "against various nomadic groups from the Eurasian Steppe.", 'assets/tourism/china.jpg',DateTime.parse('2010-10-30'),user('mds','400') ),
        ]
    ),),
    post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
        "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('sed','233'),group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
        [
          post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
              "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2021-01-10'),user('zrh','11') ),
          post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
              "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123') ),
          post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
              "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717')),
          post("Encanto", "A Colombian teenage girl has to face the frustration of being the only member of her "
              "family without magical powers.", "assets/anim/enc.jpg",DateTime.parse('2022-05-23'),user('mbn','123') ),
          post("Wish Dragon", "Determined teen Din is longing to reconnect with his childhood best friend when he meets a wish-granting"
              " dragon who shows him the magic of possibilities.", "assets/anim/wish.jpg",DateTime.parse('2020-10-10'),user('mds','1717') )
        ]
    )),




  ];

  List<group> gList = [
    group("Tourism", new user("", ""),'assets/tourism/traveller.jpg',
        [
          post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
              " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('ali','12') ),
          post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
              " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2014-12-10'),user('mmd','400') ),
          post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
              "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2019-03-16'),user('mbn','123')),
          post("Pisa Tower", "TheLeaning Tower of Pisa is one of the most remarkable architectural structures from medieval Europe. "
              "It is located in the Italian town of Pisa, one of the most visited European cities.", 'assets/tourism/italy.jpg', DateTime.parse('1999-11-10'),user('mmd','400')),
          post("China Wall", "The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection "
              "against various nomadic groups from the Eurasian Steppe.", 'assets/tourism/china.jpg',DateTime.parse('2010-10-30'),user('mds','400') ),
        ]
    ),
    group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
        [
          post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
              "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2021-01-10'),user('zrh','11') ),
          post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
              "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123') ),
          post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
              "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717')),
          post("Encanto", "A Colombian teenage girl has to face the frustration of being the only member of her "
              "family without magical powers.", "assets/anim/enc.jpg",DateTime.parse('2022-05-23'),user('mbn','123') ),
          post("Wish Dragon", "Determined teen Din is longing to reconnect with his childhood best friend when he meets a wish-granting"
              " dragon who shows him the magic of possibilities.", "assets/anim/wish.jpg",DateTime.parse('2020-10-10'),user('mds','1717') )
        ]
    ),
    group("Novel Novels", new user("user3", "333"),'assets/books/prof.jpg',[]),
    group("Best_Painters", new user("user4", "444"),'assets/art/p3.jpg',[]),
    group("Soccer", new user("user6", "666"),'assets/football/messi.jpg',[]),
    group("Cookery", new user("user5", "555"),'assets/food/pizza.jpg',[]),
    group("Luxury Car2022", new user("user5", "555"),'assets/car/Lambor.jpg',[]),
    group("Animal Photography", new user("user5", "555"),'assets/animals/panda.jpg',[]),
    //group("Moder Architecture", new user("user5", "555"),'assets/archi/p3.jpg',[]),
    //group("Digimoviez", new user("user5", "555"),'assets/movies/WorldWarZ.jpg',[]),
    //group("News", new user("user5", "555"),'assets/news/p1.jpg',[]),
    //group("Amazing ", new user("user5", "555"),'assets/Nature/Italy.jpg',[]),
  ];
  @override
  void initState() {
    sortFeed();
    super.initState();
  }
  void addGrp(group g){
    setState(() {
      gList.add(g);
    });
  }
  void editGrp(group g,String title){
    setState(() {
      g.setTitle(title);
    });
  }
  void removePstFeed(int index){
    setState(() {
      allPosts.remove(allPosts[index]);
    });
  }
  void addPostToAll(post p){
    setState(() {
      allPosts.add(p);
    });
  }
  void addPostTogList(post p){
    //widget.
  }
  void sortFeed(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: allPosts.length,
            itemBuilder: (contex, index) {
              return feedItem(
                pst: allPosts[index],
                savedPst:savedPosts,
                allPst: allPosts,
                removePst: () => removePstFeed(index),
                addGrp: () => addGrp,
                editGrp: editGrp,
                currentUser: widget.currentUser,
              );
            }),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Container(
              width: 90,
              child: IconButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => settings(addGrp,savedPosts,widget.currentUser,widget.users))
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
                        MaterialPageRoute(builder: (context) => addPost(addPostToAll,widget.currentUser))/////////////////
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
                        MaterialPageRoute(builder: (context) => groupList(gList,editGrp,savedPosts,widget.currentUser))///////////////////////////
                    );
                  },
                  icon: Icon(Icons.list_outlined)
              ),
            ),
            Container(
                width: 90,
                child: IconButton(
                    icon: Icon(Icons.home,color: Colors.white70,)
                )
            ),
          ],
        ),
      ),
    );
  }
}

class feedItem extends StatefulWidget {
  const feedItem({Key key, this.pst, this.savedPst, this.allPst, this.removePst, this.addGrp, this.editGrp, this.currentUser}) : super(key: key);
  final post pst;
  final List<post> savedPst;//
  final List<post> allPst;//
  final Function removePst;//
  final Function addGrp;//
  final Function editGrp;
  final user currentUser;
  @override
  State<feedItem> createState() => _feedItemState();
}

class _feedItemState extends State<feedItem> {
  static const snackBar = SnackBar(content: Text('Access denied'));

  void savePost(post p){
    widget.savedPst.add(p);
  }
  bool isEqual(user u1,user u2){
    if(u1.userName == u2.userName && u1.password==u2.password)
      return true;
    else
      return false;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.editGrp,widget.savedPst,widget.currentUser))
                    );
                    //go to groupPosts
                  },
                  title: Text(widget.pst.groupPublisher.name,style: TextStyle(fontSize: 22),),
                  leading: CircleAvatar(backgroundImage: AssetImage(widget.pst.groupPublisher.imageURL),
                  ),
                ),
              ),
              Positioned(
                  right: -5,
                  child: Container(child: IconButton(icon: Icon(Icons.edit, size: 16,),

                    onPressed: () {
                    if(isEqual(widget.currentUser, widget.pst.userPublisher)){
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  editPost(widget.pst))
                        );
                      });
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    },
                  ),
                  )),
              Positioned(
                  right: 25,
                  child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                    //if usere
                    onPressed: () {
                      if(isEqual(widget.currentUser, widget.pst.userPublisher))
                        widget.removePst();
                      else
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  )),
            ],
          ),
          Container(
            child:  Align(
              heightFactor: 1.7,
              alignment: Alignment(-.9, 0),
              child: Text(widget.pst.title, style: TextStyle(fontSize: 19,color: Colors.white70)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(widget.pst.imageURL),
                )),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.pst.caption,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
          Container(
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      child: IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: 20,semanticLabel: '1',),
                        onPressed: () {
                          setState(() {
                            widget.pst.setlikesNum(widget.pst.likesNum+1);
                          });
                        },
                      ),
                    ),
                    Container(
                      child: Text('${widget.pst.likesNum + widget.pst.disLikesNum }'),
                    ),
                    Container(
                      child: IconButton(icon: Icon(Icons.thumb_down_alt_outlined, size: 20,),
                          onPressed: () {
                            setState(() {
                              widget.pst.setDislikesNum(widget.pst.disLikesNum-1);
                            });

                          }),
                    ),
                    Container(
                      child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.pst.groupPublisher,widget.currentUser)));
                        },

                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(Icons.save_outlined, size: 20,),
                        onPressed: (){
                          savePost(widget.pst);
                        },
                      ),
                    ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}




