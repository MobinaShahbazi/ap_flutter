import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:redit/user.dart';
import 'feed.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList(this.gList, this.editGrp, this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort, this.grpNames);
  final List<group> gList;
  final Function editGrp;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;
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
                editGrp: widget.editGrp,
                savedPost: widget.savedPost,
                currentUser: widget.currentUser,
                saveFromGrp: widget.saveFromGrp,
                unSaveFromGrp: widget.unSaveFromGrp,
                starSort: widget.starSort,
              );
            }
        ),
      ),
    );
  }
}

class groupItem extends StatefulWidget {
  const groupItem({Key key, this.grp, this.gList, this.editGrp, this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.starSort}) : super(key: key);
  final group grp;
  final List<group> gList ;
  final Function editGrp;
  final List<post> savedPost;
  final user currentUser;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function starSort;



  @override
  State<groupItem> createState() => _groupItemState();
}

class _groupItemState extends State<groupItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       ListTile(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  groupPosts(widget.grp,widget.editGrp,widget.currentUser,widget.saveFromGrp,widget.unSaveFromGrp)));
           //go to groupPosts
         },
         title: Text(widget.grp.name),
         leading: CircleAvatar(
           backgroundImage: AssetImage(widget.grp.imageURL),
         ),
       ),
       Positioned(
         right: 10,
           child: IconButton(
           icon: Icon(widget.grp.stared? Icons.star:Icons.star_border,size: 20,color: Colors.white70,),
         onPressed: (){
             setState(() {
               widget.grp.setStared(!widget.grp.stared);
               widget.starSort();
             });
             widget.starSort();
         },
       )
       )
     ],
    );
  }
}
