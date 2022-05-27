import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addGroup.dart';
import 'package:redit/addPost.dart';
import 'package:redit/groupPart.dart';
import 'package:redit/post.dart';
import 'package:redit/settings.dart';

import 'editPost.dart';
import 'group.dart';
import 'groupPosts.dart';

class feed extends StatefulWidget {
  const feed( this.savedPst, this.allPst, this.gList, this.addGrp);
  final List<post> savedPst;
  final List<post> allPst;
  final List<group> gList;
  final Function addGrp;

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  void removePst(int index){
    setState(() {
      widget.allPst.remove(widget.allPst[index]);
    });
  }
  void addPostToAll(post p){
    setState(() {
      widget.allPst.add(p);
    });
  }
  void addPostTogList(post p){
    //widget.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.allPst.length,
            itemBuilder: (contex, index) {
              return feedItem(
                pst: widget.allPst[index],
                savedPst: widget.savedPst,
                allPst: widget.allPst,
                gList: widget.gList,
                removePst: () => removePst(index),
                addGrp: () => widget.addGrp,
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
                        MaterialPageRoute(builder: (context) => settings(widget.addGrp))//////////////////////
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
                        MaterialPageRoute(builder: (context) => addPost(addPostToAll))/////////////////
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
                        MaterialPageRoute(builder: (context) => groupList())///////////////////////////
                    );
                  },
                  icon: Icon(Icons.list_outlined)
              ),
            ),
            Container(
                width: 90,
                child: IconButton(
                    // onPressed:(){
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => feed(allPosts,savedPosts,allPosts))
                    //   );
                    // },
                    icon: Icon(Icons.home)
                )
            ),
          ],
        ),
      ),
    );
  }
}

class feedItem extends StatefulWidget {
  const feedItem({Key key, this.pst, this.savedPst, this.allPst, this.removePst, this.gList, this.addGrp}) : super(key: key);
  final post pst;
  final List<post> savedPst;
  final List<post> allPst;
  final List<group> gList;
  final Function removePst;
  final Function addGrp;



  @override
  State<feedItem> createState() => _feedItemState();
}

class _feedItemState extends State<feedItem> {
  void savePost(post p){
    widget.savedPst.add(p);
  }

  @override
  Widget build(BuildContext context) {
    int vote=0;
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
                        MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.savedPst,widget.allPst,widget.gList,widget.addGrp))
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
                    //if usere
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  editPost(widget.pst))
                        );
                      });
                    },
                  ),
                  )),
              Positioned(
                  right: 25,
                  child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                    //if usere
                    onPressed: () {
                     widget.removePst();
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
            child: Row(
              children: [
                Container(
                  child: IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: 20,semanticLabel: '1',),
                    onPressed: () {
                      setState(() {
                        vote++;
                      });
                    },
                  ),
                ),
                Container(
                  child: Text('$vote'),
                ),
                Container(
                  child: IconButton(icon: Icon(Icons.thumb_down_alt_outlined, size: 20,),
                      onPressed: () {
                        setState(() {
                          vote--;
                        });

                      }),
                ),
                Container(
                  child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,)
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 192),
                  child: IconButton(icon: Icon(Icons.save_outlined, size: 20,),
                    onPressed: (){
                      savePost(widget.pst);
                      //print(widget.savedPst.length);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




