import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redit/chooseGroup.dart';
import 'package:redit/groupPart.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/settings.dart';
import 'package:redit/user.dart';
import 'group.dart';
import 'groupPosts.dart';

class feed extends StatefulWidget {
  const feed(this.currentUser, this.users, this.setCurrentUser, this.feedPosts, this.removePstFeed );
  final user currentUser;
  final List<user> users;
  final List<post> feedPosts;
  final Function setCurrentUser;
  final Function removePstFeed;
  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  List<post> savedPosts=[];
  List<post> allPosts=[
    post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
        "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2022-03-10'),user('mbn'),
        [
          comment(user('ali'), 'masterpiece!!!'),
          comment(user('maryam'), 'bah bah'),
          comment(user('anxious soul'), 'fantastic :))'),
        ]
        ,group("IMDb", user("zizi"),'assets/anim/imdb.jpg',
        [
          post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
              "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2022-03-10'),user('zrh'),[] ),
          // post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
          //     "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123'),[] ),
          // post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
          //     "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717'),[]),
          ]
    )
    ),
    post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
        " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('mmd',),
      [
        comment(user('amin'), 'great'),
        comment(user('sahar'), 'nice'),
        comment(user('ali'), 'masterpiece :))'),
      ]
      ,group("Tourism", user('mbn'),'assets/tourism/traveller.jpg',
          [
            post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
                " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('ali'),[] ),
            // post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
            //     " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2018-01-27'),user('mmd','400'),[] ),
            // post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
            //     "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2017-03-16'),user('mbn','123'),[]),
          ]
      ),),
    post("A Man Called Ove", "Ove, an ill-tempered, isolated retiree who spends his days enforcing block association rules and visiting his wife's grave, has finally given up on "
        "life just as an unlikely friendship develops with his boisterous new neighbors.", "assets/book/ove2.jpg" ,DateTime.parse('2020-10-19'), user('mds'),
      [
        comment(user('maryam'), 'so cute'),
        comment(user('ali'), 'my favorite animated film'),
        comment(user('anxious soul'), 'I love it'),
      ],
      group("Novel Novels", new user("user3"),'assets/book/p2.jpg',
          [
            //   post("A Man Called Ove", "Ove, an ill-tempered, isolated retiree who spends his days enforcing block association rules and visiting his wife's grave, has finally given up on "
            //       "life just as an unlikely friendship develops with his boisterous new neighbors.", "assets/book/ove2.jpg" ,DateTime.parse('2020-10-19'), user('mds','1717'),[]),
            //   post("Me Before You", "Me Before You is a romance novel written by Jojo Moyes. The book was first published on 5 January 2012 in the United Kingdom. A sequel titled After"
            //       " You was released on 24 September 2015 through Pamela Dorman Books.", "assets/book/me.jpg", DateTime.parse('2015-05-15'), user('mbn','123'),[])
          ]
      ),
    ),
    /*
    post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
        "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717'),
      [
        comment(user('maryam','12'), 'so cute'),
        comment(user('ali', 'asd'), 'my favorite animated film'),
        comment(user('anxious soul','000'), 'I love it'),
      ],
      group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
          [
            post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
                "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2022-03-10'),user('zrh','11'),[] ),
            post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
                "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123'),[] ),
            post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
                "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717'),[]),
          ]
      ),
    ),
    post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
        "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('sed','233'),
        [
          comment(user('maryam','12'), 'so cute'),
          comment(user('ali', 'asd'), 'my favorite animated film'),
          comment(user('anxious soul','000'), 'I love it'),
        ],
        group("IMDb", user("user1", "Aa111111"),'assets/anim/imdb.jpg',
            [
              post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
                  "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2022-03-10'),user('zrh','11'),[] ),
              post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
                  "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123'),[] ),
              post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
                  "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717'),[]),
            ]
        )
    ),
    post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
        " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2018-01-27'),user('mmd','400') ,
        [
          comment(user('maryam','12'), 'so cute'),
          comment(user('ali', 'asd'), 'my favorite animated film'),
          comment(user('anxious soul','000'), 'I love it'),
        ],
      group("Tourism", new user("", ""),'assets/tourism/traveller.jpg',
          [
            post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
                " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('','') ,[]),
            post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
                " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2018-01-27'),user('mmd','400') ,[]),
            post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
                "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2017-03-16'),user('mbn','123'),[]),
            ]
      ),
    ),
    post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
        "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2017-03-16'),user('mbn','123'),
      [
        comment(user('maryam','12'), 'so cute'),
        comment(user('ali', 'asd'), 'my favorite animated film'),
        comment(user('','000'), 'I love it'),
      ],
      group("Tourism", new user("", ""),'assets/tourism/traveller.jpg',
          [
            post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
                " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('','') ,[]),
            post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
                " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2018-01-27'),user('mmd','400') ,[]),
            post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
                "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2017-03-16'),user('mbn','123'),[]),
            ]
      ),
    ),



    post("Me Before You", "Me Before You is a romance novel written by Jojo Moyes. The book was first published on 5 January 2012 in the United Kingdom. A sequel titled After"
        " You was released on 24 September 2015 through Pamela Dorman Books.", "assets/book/me.jpg", DateTime.parse('2015-05-15'), user('mbn','123'),
        [
          comment(user('amin','12'), 'great'),
          comment(user('sahar','000'), 'nice'),
          comment(user('ali', 'asd'), 'masterpiece :))'),
        ],
      group("Novel Novels", new user("user3", "333"),'assets/book/p2.jpg',
          [
            post("A Man Called Ove", "Ove, an ill-tempered, isolated retiree who spends his days enforcing block association rules and visiting his wife's grave, has finally given up on "
                "life just as an unlikely friendship develops with his boisterous new neighbors.", "assets/book/ove2.jpg" ,DateTime.parse('2020-10-19'), user('mds','1717'),[]),
            post("Me Before You", "Me Before You is a romance novel written by Jojo Moyes. The book was first published on 5 January 2012 in the United Kingdom. A sequel titled After"
                " You was released on 24 September 2015 through Pamela Dorman Books.", "assets/book/me.jpg", DateTime.parse('2015-05-15'), user('mbn','123'),[])
          ]
      ),
    ),
    post("Starry Night", "The Starry Night is an oil-on-canvas painting by the Dutch Post-Impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the"
        " east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an imaginary village.", 'assets/art/star2.jpg',  DateTime.parse('2017-11-17'), user('kourosh','123'),
        [
          comment(user('amin','12'), 'great'),
          comment(user('sahar','000'), 'nice'),
          comment(user('ali', 'asd'), 'masterpiece :))'),
        ],
      group("Best_Painters", new user("user4", "444"),'assets/art/p1.jpg',
          [
            post("Starry Night", "The Starry Night is an oil-on-canvas painting by the Dutch Post-Impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the"
                " east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an imaginary village.", 'assets/art/star2.jpg',  DateTime.parse('2017-11-17'), user('kourosh','123'),[]),
            post("Abstract Painting", "Abstract art uses visual language of shape, form, color and line to create a composition which may exist with a degree of independence from visual references in the world.[1] Western art had been,"
                " from the Renaissance up to the middle of the 19th century, underpinned by the logic of perspective and an attempt to reproduce an illusion of visible reality. ",  'assets/art/abs.jpg',  DateTime.parse('1889-09-11'), user('kourosh','123'),[])
          ]
      ),
    ),
    post("Abstract Painting", "Abstract art uses visual language of shape, form, color and line to create a composition which may exist with a degree of independence from visual references in the world.[1] Western art had been,"
        " from the Renaissance up to the middle of the 19th century, underpinned by the logic of perspective and an attempt to reproduce an illusion of visible reality. ",  'assets/art/abs.jpg',  DateTime.parse('1889-09-11'), user('kourosh','123'),
      [
        comment(user('amin','12'), 'great'),
        comment(user('sahar','000'), 'nice'),
        comment(user('ali', 'asd'), 'masterpiece :))'),
      ],
      group("Best_Painters", new user("user4", "444"),'assets/art/p1.jpg',
          [
            post("Starry Night", "The Starry Night is an oil-on-canvas painting by the Dutch Post-Impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the"
                " east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an imaginary village.", 'assets/art/star2.jpg',  DateTime.parse('2017-11-17'), user('kourosh','123'),[]),
            post("Abstract Painting", "Abstract art uses visual language of shape, form, color and line to create a composition which may exist with a degree of independence from visual references in the world.[1] Western art had been,"
                " from the Renaissance up to the middle of the 19th century, underpinned by the logic of perspective and an attempt to reproduce an illusion of visible reality. ",  'assets/art/abs.jpg',  DateTime.parse('1889-09-11'), user('kourosh','123'),[])
          ]
      ),
    )
    */
  ];

  List<group> gList = [
    group("Tourism", new user("ali76"),'assets/tourism/traveller.jpg',
        [
          post("Taj Mahal", "An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor"
              " Shah Jahan in memory of his favourite wife.", 'assets/tourism/india.jpg',DateTime.parse('2021-11-10'),user('','') ,[]),
         //  post("Nasir al-Mulk Mosque", "The Nasir al-Mulk Mosque, also known as the Pink Mosque, is a traditional mosque in Shiraz, Iran."
         //      " It was built during Qajar dynasty rule of Iran.", 'assets/tourism/nasir.jpg',DateTime.parse('2018-01-27'),user('mmd','400') ,[]),
         //  post("St. Basil’s Cathedral", "St. Basil’s Cathedral is Moscow’s most famous artistic work of architecture. Also called Pokrovsky "
         //      "Cathedral or The Cathedral of Intercession of the Virgin by the Moat, it is the most recognizable Russian building.", "assets/tourism/russia.jpg", DateTime.parse('2017-03-16'),user('mbn','123'),[]),
          ]
        ,false
    ),
    group("IMDb", user("mmd"),'assets/anim/imdb.jpg',
        [
          post("Hotel Transylvania", "Dracula, who operates a high-end resort away from the human world, goes into overprotective mode when a "
              "boy discovers the resort and falls for the count's teenaged daughter.", "assets/anim/hotel.jpg",DateTime.parse('2022-03-10'),user('zrh','11') ,[]),
          // post("Zootopia", "In a city of anthropomorphic animals, a rookie bunny cop and a cynical con artist fox must work "
          //     "together to uncover a conspiracy.", "assets/anim/zoo.jpg",DateTime.parse('2018-11-10'),user('mbn','123'),[] ),
          // post("Big Hero", "A special bond develops between plus-sized inflatable robot Baymax and prodigy Hiro Hamada, who together team up "
          //     "with a group of friends to form a band of high-tech heroes.", "assets/anim/hero.jpg", DateTime.parse('2016-09-14'),user('mds','1717'),[]),
           ]
        ,true
    ),
     group("Novel Novels", new user("ghost"),'assets/book/p2.jpg',
         [
           post("A Man Called Ove", "Ove, an ill-tempered, isolated retiree who spends his days enforcing block association rules and visiting his wife's grave, has finally given up on "
               "life just as an unlikely friendship develops with his boisterous new neighbors.", "assets/book/ove2.jpg" ,DateTime.parse('2020-10-19'), user('mds','1717'),[]),
           // post("Me Before You", "Me Before You is a romance novel written by Jojo Moyes. The book was first published on 5 January 2012 in the United Kingdom. A sequel titled After"
           //     " You was released on 24 September 2015 through Pamela Dorman Books.", "assets/book/me.jpg", DateTime.parse('2015-05-15'), user('mbn','123'),[])
         ]
         ,false
     ),
     group("Best_Painters", new user("mbn"),'assets/art/p1.jpg',
         [
           // post("Starry Night", "The Starry Night is an oil-on-canvas painting by the Dutch Post-Impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the"
           //     " east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an imaginary village.", 'assets/art/star2.jpg',  DateTime.parse('2017-11-17'), user('kourosh','123'),[]),
           // post("Abstract Painting", "Abstract art uses visual language of shape, form, color and line to create a composition which may exist with a degree of independence from visual references in the world.[1] Western art had been,"
           //     " from the Renaissance up to the middle of the 19th century, underpinned by the logic of perspective and an attempt to reproduce an illusion of visible reality. ",  'assets/art/abs.jpg',  DateTime.parse('1889-09-11'), user('kourosh','123'),[])
         ]
         ,false
     ),
     group("Soccer", new user("cutest"),'assets/football/messi.jpg',[],false),
     group("Cookery", new user("user5", "555"),'assets/food/pizza.jpg',[],false),
     group("Luxury Car2022", new user("user5", "555"),'assets/car/Lambor.jpg',[],false),
     group("Animal Photography", new user("user5", "555"),'assets/animals/panda.jpg',[],true),
     group("Moder Architecture", new user("user5", "555"),'assets/archi/p3.jpg',[],false),
     group("Digimoviez", new user("user5", "555"),'assets/movies/WorldWarZ.jpg',[],false),
     group("News", new user("user5", "555"),'assets/news/p1.jpg',[],false),
     group("Amazing Nature", new user("user5", "555"),'assets/Nature/Italy.jpg',[],false),
  ];
  List<String> grpNames=["Tourism","IMDb","Novel Novels","Best_Painters","Soccer","Cookery","Luxury Car2022","Animal Photography","Moder Architecture","Digimoviez","News","Amazing Nature",];
  @override
  void initState() {
    sortFeed();
    super.initState();
  }
  void addGrp(group g){
    setState(() {
      gList.add(g);
      grpNames.add(g.name);
    });
  }
  void editGrpFromFeed(List<int> indexes,String name){
    setState(() {
      for(int i=0;i<indexes.length;i++){
        allPosts[indexes[i]].groupPublisher.setName(name);
      }
    });
  }
  // void removePstFeed(int index){
  //   setState(() {
  //     widget.feedPosts.remove(widget.feedPosts[index]);
  //     print("removeeeeeeeeeeeee");
  //   });
  // }
  void removePstFeedGlist(int gindex,int pindex){
    setState(() {
      gList[gindex].posts.removeAt(pindex);
    });
  }
  void addPst(post p,group g){
    setState(() {
      allPosts.add(p);
      widget.feedPosts.add(p);
      int index=0;
      for(int i=0;i<gList.length;i++){
        if(gList[i].name==g.name)
          index=i;
      }
      gList[index].posts.add(p);
    });
  }
  void starSort(){
      List<group> copy=[];
      for(int i=0;i<gList.length;i++){
        if(gList[i].stared)
          copy.add(gList[i]);
      }
      for(int i=0;i<gList.length;i++){
        if(!gList[i].stared)
          copy.add(gList[i]);
      }
      gList.clear();
      gList.addAll(copy);
  }
  void sortFeed(){
    final DateFormat formatter = DateFormat('yyyyMMddHHmm');
    for(int i=0;i<widget.feedPosts.length-1;i++){
      for(int j=0;j<widget.feedPosts.length-1-i;j++) {
        if(int.parse(formatter.format(widget.feedPosts[j].date)) < int.parse(formatter.format(widget.feedPosts[j+1].date))){
          setState( () {
            post p=widget.feedPosts[j];
            widget.feedPosts[j]=widget.feedPosts[j+1];
            widget.feedPosts[j+1]=p;
          });
        }
      }
    }
  }
void savefromGrp(post p,group g) {
    post p2=post(p.title, p.caption, p.imageURL, p.date, p.userPublisher,[],g);
    savedPosts.add(p2);
}
void unSaveGrp(post p,group g){
    post p2=post(p.title, p.caption, p.imageURL, p.date, p.userPublisher,[],g);
    setState(() {
      savedPosts.remove(p2);
    });
}
  Map stringToMap(String str){
    List<String> arr=str.split(",,");
    Map<String,String> map = {};
    for(int i=0;i<arr.length;i++){
      int colon=arr[i].indexOf(":");
      String key=arr[i].substring(0,colon);
      String value=arr[i].substring(colon+1);
      map[key]=value;
    }
    return map;
  }
  List<group> groupsList=[];
  getGList()async{
    print("im alive0");
    String request="viewGList\n : \u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        String str=String.fromCharCodes(response);
        print("resp: $str");
        List<String> arr=str.split('\n');
        var maps = <Map>[];
        for(int i=0;i<arr.length;i++){
          maps.add(stringToMap(arr[i]));
        }
        groupsList=[];
        for(int i=0;i<maps.length;i++){
          group g=group(maps[i]["name"], user(maps[i]["user"]), maps[i]["image"],[],maps[i]["fav"]=='true');
          groupsList.add(g);
        }
        print("im alive1");
        Navigator.push(context, MaterialPageRoute(builder: (context) => groupList(groupsList,savedPosts,widget.currentUser,savefromGrp,unSaveGrp,starSort,grpNames,allPosts,editGrpFromFeed,widget.removePstFeed)));
      });
    });
  }
  getGListNewPst()async{
    print("im alive0");
    String request="viewGList\n : \u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        String str=String.fromCharCodes(response);
        print("resp: $str");
        List<String> arr=str.split('\n');
        var maps = <Map>[];
        for(int i=0;i<arr.length;i++){
          maps.add(stringToMap(arr[i]));
        }
        groupsList=[];
        for(int i=0;i<maps.length;i++){
          group g=group(maps[i]["name"], user(maps[i]["user"]), maps[i]["image"],[],maps[i]["fav"]=='true');
          groupsList.add(g);
        }
        print("im alive1");
        Navigator.push(context, MaterialPageRoute(builder: (context) => chooseGroup(groupsList,widget.currentUser, addPst,sortFeed)));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.feedPosts.length,
            itemBuilder: (contex, index) {
              return feedItem(
                pst: widget.feedPosts[index],
                savedPst:savedPosts,
                allPst: widget.feedPosts,
                removePst: () => widget.removePstFeed,
                addGrp: () => addGrp,
                currentUser: widget.currentUser,
                saveFromGrp: savefromGrp,
                unSaveFromGrp: unSaveGrp,
                removePstFeedGlist: removePstFeedGlist,
                gList: gList,

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => settings(addGrp,savedPosts,widget.currentUser,widget.users,savefromGrp,unSaveGrp,widget.setCurrentUser,widget.removePstFeed,allPosts))
                    );
                  },
                  icon: Icon(Icons.settings)
              ),
            ),
            Container(
              width: 100,
              child: IconButton(
                  onPressed:(){
                    getGListNewPst();
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => chooseGroup(gList, widget.currentUser, addPst,sortFeed))/////////////////);
                  },
                  icon: Icon(Icons.add)
              ),
            ),
            Container(
              width: 100,
              child: IconButton(
                  onPressed:(){
                    getGList();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => groupList(groupsList,savedPosts,widget.currentUser,savefromGrp,unSaveGrp,starSort,grpNames,allPosts,editGrpFromFeed,removePstFeed)));
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
  const feedItem({Key key, this.pst, this.savedPst, this.allPst, this.removePst, this.addGrp, this.editGrp, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.removePstFeedGlist, this.gList}) : super(key: key);
  final post pst;
  final List<post> savedPst;
  final List<group> gList;
  final List<post> allPst;
  final Function removePst;
  final Function addGrp;
  final Function editGrp;
  final Function removePstFeedGlist;
  final user currentUser;
  final Function saveFromGrp;
  final Function unSaveFromGrp;


  @override
  State<feedItem> createState() => _feedItemState();
}

class _feedItemState extends State<feedItem> {
  static const snackBar = SnackBar(content: Text('Access denied'));

  void savePost(post p){
    setState(() {
      widget.savedPst.add(p);
    });
  }
  void unSaveFeed(post p){
    widget.savedPst.remove(p);
  }
  int gIndex(post p){
    int index=0;
    for(int i=0;i<widget.gList.length;i++){
      if(p.groupPublisher.name==widget.gList[i].name){
        index=i;
      }
    }
    return index;
  }
  int pIndex(post p){
    int indexg=gIndex(p);
    int pIndex=0;
    for(int i=0;i<widget.gList[indexg].posts.length;i++){
      if(p.title==widget.gList[indexg].posts[i].title && p.caption==widget.gList[indexg].posts[i].caption)
        pIndex=i;
    }
    return pIndex;
  }
  bool isSaved=false;
  bool isLiked=false;
  bool isDisliked=false;
  void like(){
    if(!isLiked) {
      int num = widget.pst.likesNum;
      num--;
      setState(() {
        widget.pst.setlikesNum(num);
      });
    }
    else {
      int num = widget.pst.likesNum;
      num++;
      setState(() {
        widget.pst.setlikesNum(num);
      });
      if(isDisliked) {
        int num = widget.pst.disLikesNum;
        num--;
        setState(() {
          widget.pst.setDislikesNum(num);
        });
        isDisliked=!isDisliked;
      }
    }
  }
  void dislike(){
    if(!isDisliked) {
      int num = widget.pst.disLikesNum;
      num--;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
    }
    else {
      int num = widget.pst.disLikesNum;
      num++;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
      if(isLiked) {
        int num = widget.pst.likesNum;
        num--;
        setState(() {
          widget.pst.setlikesNum(num);
        });
        isLiked=!isLiked;
      }
    }
  }
  bool isEqual(user u1,user u2){
    if(u1.userName == u2.userName && u1.password==u2.password)
      return true;
    else
      return false;
  }
  sendSaved(String currentUser,String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike,String comment) async {
    print("sendingggg");
    String request="savePost\ncurrentUser:$currentUser,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user,,groupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,like:$like,,dislike:$dislike,,comment:$comment\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  resetLike(String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike,String comment) async {
    print("sendingggg");
    String request="likeDislike\ntitle:$title,,caption:$caption,,image:$image,,date:$data,,user:$user,,groupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,like:$like,,comment:$comment\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  Map stringToMap(String str){
    List<String> arr=str.split(",,");
    Map<String,String> map = {};
    for(int i=0;i<arr.length;i++){
      int colon=arr[i].indexOf(":");
      String key=arr[i].substring(0,colon);
      String value=arr[i].substring(colon+1);
      map[key]=value;
    }
    return map;
  }
  List<post> gPosts=[];
  getGroupPosts(String name)async{
    print("to getGroupPosts");
    String request="getGroupPosts\nname:$name\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        String str=String.fromCharCodes(response);
        print("rsponse: $str");
        if(str!="\u0000") {
          List<String> arr = str.split("\n");
          var maps = <Map>[];
          print(arr.length);
          for (int i = 0; i < arr.length; i++) {
            maps.add(stringToMap(arr[i]));
          }
          gPosts = [];
          for (int i = 0; i < maps.length; i++) {
            post p = post(maps[i]["title"], maps[i]["caption"], maps[i]["image"], DateTime.parse(maps[i]["date"]), user(maps[i]["user"]), [], group(maps[i]["groupName"], user(maps[i]["groupAdmin"]), maps[i]["groupImage"]),int.parse(maps[i]["like"]),int.parse(maps[i]["dislike"]),int.parse(maps[i]["comment"]));
            setState(() {
              gPosts.add(p);
            });
          }
        }
        else
          gPosts=[];
        group chosenGrp=group(name, widget.pst.groupPublisher.admin, widget.pst.groupPublisher.imageURL,gPosts,widget.pst.groupPublisher.stared);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  groupPosts(chosenGrp,widget.currentUser,widget.saveFromGrp,widget.unSaveFromGrp,widget.savedPst,widget.removePst,widget.allPst)));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 5,
          ),
          Container(
            child: ListTile(
              onTap: (){
                getGroupPosts(widget.pst.groupPublisher.name);
              },
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(widget.pst.groupPublisher.name,style: TextStyle(fontSize: 22),),
                    ),
                  ),
                ],
              ),
              leading: CircleAvatar(backgroundImage: AssetImage(widget.pst.groupPublisher.imageURL),
              ),
            ),
          ),
          Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Align(
                      heightFactor: 1.7,
                      alignment: Alignment(-.9, 0),
                      child: Text(widget.pst.title, style: TextStyle(fontSize: 19,color: Colors.white)),
                    ),
                    Align(
                      alignment: Alignment(-.9, 0),
                      child: Container(
                          child: Text((DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date)),style: TextStyle(fontSize: 15,color: Colors.white70))
                      ),
                    ),
                  ],
                ),
                // Positioned(
                //     right: -5,
                //     bottom: 0,
                //     child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                //       //if usere
                //       onPressed: () {
                //         if(isEqual(widget.currentUser, widget.pst.groupPublisher.admin)){
                //           widget.removePst();
                //           widget.removePstFeedGlist(gIndex(widget.pst),pIndex(widget.pst));
                //         }
                //         else
                //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //       },
                //     ),
                //     )
                // ),
              ],
            )
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
                      child: IconButton(icon: Icon(isLiked ?Icons.thumb_up:Icons.thumb_up_alt_outlined , size: 20,),
                        onPressed: () {
                          setState(() {
                            isLiked = ! isLiked;
                          });
                          like();
                          resetLike(widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString(),widget.pst.commentsNum.toString());
                        },
                      ),
                    ),
                    Container(
                      child: Text('${widget.pst.likesNum-widget.pst.disLikesNum}'),
                    ),
                    Container(
                      child: IconButton(icon: Icon(isDisliked?Icons.thumb_down:Icons.thumb_down_alt_outlined, size: 20,),
                          onPressed: () {
                            setState(() {
                              isDisliked = ! isDisliked;
                            });
                            dislike();
                            resetLike(widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString(),widget.pst.commentsNum.toString());
                          }),
                    ),
                    Container(
                      child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.pst.groupPublisher,widget.currentUser,isLiked,isDisliked)));
                        },

                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(isSaved? Icons.save:Icons.save_outlined, size: 20,),
                        onPressed: (){
                        setState(() {
                          isSaved=!isSaved;
                        });
                        if(isSaved){
                          sendSaved(widget.currentUser.userName, widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString(),widget.pst.commentsNum.toString());
                          savePost(widget.pst);
                        }
                        else{
                          unSaveFeed(widget.pst);
                        }
                        },
                      ),
                    ),
                )
              ],
            )
          ),
          Container(
            height: .7,
            width: 300,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }
}




