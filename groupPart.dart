import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/editGroup.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:redit/user.dart';
import 'feed.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList(this.gList,this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort, this.grpNames, this.allPosts, this.editGrpFromFeed);
  final List<group> gList;
  final List<post> allPosts;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;
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
    widget.starSort();
    super.initState();
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
              );
            }
        ),
      ),
    );
  }
}

class groupItem extends StatefulWidget {
  const groupItem({Key key, this.grp, this.gList,this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort, this.insert, this.uninsert, this.editGrp, this.indexOfEdit, this.allPosts, this.editGrpFromFeed}) : super(key: key);
  final group grp;
  final List<group> gList ;
  final List<post> savedPost;
  final user currentUser;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;
  final Function insert;
  final Function uninsert;
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
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       ListTile(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  groupPosts(widget.grp,widget.currentUser,widget.saveFromGrp,widget.unSaveFromGrp,widget.savedPost)));
           //go to groupPosts
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
