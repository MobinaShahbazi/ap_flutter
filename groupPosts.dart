import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addPost.dart';
import 'package:redit/editPost.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class groupPosts extends StatefulWidget {
  const groupPosts(this.grp, this.savedPst);

  final group grp;
  final List<post> savedPst;


  @override
  State<groupPosts> createState() => _groupPostsState();
}

class _groupPostsState extends State<groupPosts> {
  
  void removePst(int index){
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
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.grp.posts.length,
            itemBuilder: (contex, index) {
              return postItem(
                pst: widget.grp.posts[index],
                grp: widget.grp,
                removePst: ()=> removePst(index),
                saved: widget.savedPst,

              );
            }),
      ),
    );
  }
}

class postItem extends StatefulWidget {
  const postItem({Key key, this.pst, this.grp, this.removePst, this.saved,}) : super(key: key);
  final post pst;
  final group grp;
  final   Function removePst;
  final List<post> saved;

  @override
  State<postItem> createState() => _postItemState();
}

class _postItemState extends State<postItem> {
  void savePost(post p){
    widget.saved.add(p);
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

