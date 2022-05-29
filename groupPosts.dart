import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addPost.dart';
import 'package:redit/editPost.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';
import 'package:redit/settings.dart';

import 'addGroup.dart';
import 'editGroup.dart';
import 'feed.dart';
import 'groupPart.dart';

class groupPosts extends StatefulWidget {
  const groupPosts(this.grp, this.editGrp, this.savedPost);
  final group grp;
  final Function editGrp;
  final List<post> savedPost;

  @override
  State<groupPosts> createState() => _groupPostsState();
}

class _groupPostsState extends State<groupPosts> {

  void removePstGrp(int index){
    setState(() {
      widget.grp.posts.remove(widget.grp.posts[index]);
    });
  }
  void addPst(post p){
    setState(() {
      widget.grp.posts.add(p);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.grp.imageURL),
        ),
        title: Text(
          widget.grp.name,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [IconButton(
            onPressed: (){
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => editGroup(widget.grp,widget.editGrp))
                );
              });
            },
            icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.grp.posts.length,
            itemBuilder: (contex, index) {
              return postItem(
                pst: widget.grp.posts[index],
                grp: widget.grp,
                removePst: ()=> removePstGrp(index),
                savedPost: widget.savedPost,

              );
            }),
      ),

    );
  }
}

class postItem extends StatefulWidget {
  const postItem({Key key, this.pst, this.grp, this.removePst, this.savedPost,}) : super(key: key);
  final post pst;
  final group grp;
  final Function removePst;
  final List<post> savedPost;
  @override
  State<postItem> createState() => _postItemState();
}

class _postItemState extends State<postItem> {
  void savePostGrp(post p){
    widget.savedPost.add(p);
  }
  @override
  Widget build(BuildContext context) {
    int vote=0;
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                heightFactor: 1.7,
                alignment: Alignment(-.9, 0),
                child: Text(widget.pst.title, style: TextStyle(fontSize: 25)),
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
                      child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,)
                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(Icons.save_outlined, size: 20,),
                        onPressed: (){
                          savePostGrp(widget.pst);
                          print(widget.savedPost.length);
                        },
                      ),
                    )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

