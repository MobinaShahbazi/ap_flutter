import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addPost.dart';
import 'package:redit/groupPosts.dart';
import 'package:redit/post.dart';
import 'package:redit/settings.dart';
import 'package:redit/user.dart';
import 'feed.dart';
import 'group.dart';
class chooseGroup extends StatefulWidget {
  const chooseGroup(this.gList,this.currentUser, this.addPst, this.sortFeed);
  final List<group> gList;
  final Function addPst;
  final user currentUser;
  final Function sortFeed;


  @override
  State<chooseGroup> createState() => _chooseGroupState();
}

class _chooseGroupState extends State<chooseGroup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post to"),
      ),

      body: Container(
        child: ListView.builder(
            itemCount: widget.gList.length,
            itemBuilder:  (context,index){
              return availableItem(
                grp: widget.gList[index],
                gList: widget.gList,
                addPst: widget.addPst,
                currentUser: widget.currentUser,
                sortFeed: widget.sortFeed,
              );
            }
        ),
      ),
    );
  }
}

class availableItem extends StatefulWidget {
  const availableItem({Key key, this.grp, this.gList, this.addPst, this.currentUser, this.sortFeed}) : super(key: key);
  final group grp;
  final List<group> gList ;
  final Function addPst;
  final user currentUser;
  final Function sortFeed;

  @override
  State<availableItem> createState() => _availableItemState();
}

class _availableItemState extends State<availableItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  addPost(widget.addPst, widget.currentUser,widget.grp,widget.sortFeed))
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
