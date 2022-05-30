import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:redit/settings.dart';
import 'package:redit/user.dart';
import 'feed.dart';
import 'group.dart';

class groupList extends StatefulWidget {
  const groupList(this.gList, this.editGrp, this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp);
  final List<group> gList;
  final Function editGrp;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final List<post> savedPost;
  final user currentUser;

  @override
  State<groupList> createState() => _groupListState();
}

class _groupListState extends State<groupList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
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
              );
            }
        ),
      ),
    );
  }
}

class groupItem extends StatefulWidget {
  const groupItem({Key key, this.grp, this.gList, this.editGrp, this.savedPost, this.currentUser, this.saveFromGrp, this.unSaveFromGrp}) : super(key: key);
  final group grp;
  final List<group> gList ;
  final Function editGrp;
  final List<post> savedPost;
  final user currentUser;
  final Function saveFromGrp;
  final Function unSaveFromGrp;


  @override
  State<groupItem> createState() => _groupItemState();
}

class _groupItemState extends State<groupItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  groupPosts(widget.grp,widget.editGrp,widget.currentUser,widget.saveFromGrp,widget.unSaveFromGrp))
          );
          //go to groupPosts
        },
        title: Text(widget.grp.name),
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.grp.imageURL),
        ),
      ),
    );
  }
}
