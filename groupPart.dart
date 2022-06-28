import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/editGroup.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:redit/user.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList(this.gList,this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort, this.grpNames, this.allPosts, this.editGrpFromFeed, this.removePstFeed);
  final List<group> gList;
  final List<post> allPosts;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;
  final Function removePstFeed;
  final Function editGrpFromFeed;
  final List<post> savedPost;
  final user currentUser;
  final List<String> grpNames;


  @override
  State<groupList> createState() => _groupListState();
}

class _groupListState extends State<groupList> {
  @override
  void initState() {
    starSort();
    super.initState();
  }
  void starSort(){
    List<group> copy=[];
    for(int i=0;i<widget.gList.length;i++){
      if(widget.gList[i].stared)
        copy.add(widget.gList[i]);
    }
    for(int i=0;i<widget.gList.length;i++){
      if(!widget.gList[i].stared)
        copy.add(widget.gList[i]);
    }
    widget.gList.clear();
    widget.gList.addAll(copy);
  }
  group findGrp(String name){
    for(int i=0;i<widget.gList.length;i++){
      if(name==widget.gList[i].name){
        return widget.gList[i];
      }
    }
  }
  void insert(int index){
    int staredCount=0;
    for(int i=0;i<widget.gList.length;i++){
      if(widget.gList[i].stared)
        staredCount++;
    }
    setState(() {
      widget.gList.insert(staredCount-1, widget.gList[index]);
      widget.gList.removeAt(index+1);
    });
  }
  Void unInsert(int index){
    print('hi w');
    int staredCount=0;
    for(int i=0;i<widget.gList.length;i++){
      if(widget.gList[i].stared)
        staredCount++;
    }
    setState(() {
      widget.gList.insert(staredCount+1, widget.gList[index]);
      widget.gList.removeAt(index);
    });
  }
  void editGrp(int index,String title){
    setState(() {
      widget.gList[index].setName(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
    title: const Text('Search'),
    onSearch: (value) => setState(() => (){}),
    suggestions: widget.grpNames
    ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.gList.length,
            itemBuilder:  (context,index){
              return groupItem(
                grp: widget.gList[index],
                gList: widget.gList,
                savedPost: widget.savedPost,
                currentUser: widget.currentUser,
                saveFromGrp: widget.saveFromGrp,
                unSaveFromGrp: widget.unSaveFromGrp,
                starSort: widget.starSort,
                insert: ()=> insert(index),
                uninsert: ()=> unInsert(index),
                editGrp: editGrp,
                indexOfEdit: index,
                allPosts: widget.allPosts,
                editGrpFromFeed: widget.editGrpFromFeed,
                removePstFeed: widget.removePstFeed,
              );
            }
        ),
      ),
    );
  }
}

class groupItem extends StatefulWidget {
  const groupItem({Key key, this.grp, this.gList,this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort, this.insert, this.uninsert, this.editGrp, this.indexOfEdit, this.allPosts, this.editGrpFromFeed, this.removePstFeed}) : super(key: key);
  final group grp;
  final List<group> gList ;
  final List<post> savedPost;
  final user currentUser;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;
  final Function insert;
  final Function uninsert;
  final Function removePstFeed;
  final Function editGrp;
  final Function editGrpFromFeed;
  final int indexOfEdit;
  final List<post> allPosts;




  @override
  State<groupItem> createState() => _groupItemState();
}

class _groupItemState extends State<groupItem> {
  static const snackBar = SnackBar(content: Text('Access denied',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);

  bool isEqual(user u1,user u2){
    if(u1.userName == u2.userName && u1.password==u2.password)
      return true;
    else
      return false;
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
        group chosenGrp=group(name, widget.grp.admin, widget.grp.imageURL,gPosts,widget.grp.stared);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  groupPosts(chosenGrp,widget.currentUser,widget.saveFromGrp,widget.unSaveFromGrp,widget.savedPost,widget.removePstFeed,widget.allPosts)));
      });
    });
  }
  changeFav(String name, String user, String image, String fav)async{
    print("get called");
    String request="changeFavorite\nimage:$image,,fav:$fav,,name:$name,,user:$user\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      print("requ: $request");
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       ListTile(
         onTap: (){
           getGroupPosts(widget.grp.name);
         },
         title: Text(widget.grp.name),
         leading: CircleAvatar(
           backgroundImage: AssetImage(widget.grp.imageURL),
         ),
       ),
       Positioned(
         right: 30,
           child: IconButton(
           icon: Icon(widget.grp.stared? Icons.star:Icons.star_border,size: 20,color: Colors.white70,),
         onPressed: (){
             setState(() {
               changeFav(widget.grp.name,widget.grp.admin.userName,widget.grp.imageURL,(!widget.grp.stared).toString()) ;
               widget.grp.setStared(!widget.grp.stared);
               if(widget.grp.stared)
                  widget.insert();
               else
                 widget.uninsert();
             });
         },
       )
       ),
       Positioned(
           right: -10,
           child: IconButton(
             icon: Icon(Icons.edit,size: 15,color: Colors.white70,),
             onPressed: (){
               if(!isEqual(widget.currentUser, widget.grp.admin)){
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
               }
               else
               Navigator.push(context, MaterialPageRoute(builder: (context) => editGroup(widget.grp, widget.editGrp, widget.indexOfEdit,widget.allPosts,widget.editGrpFromFeed) ));
             },
           )
       )
     ],
    );
  }
}
