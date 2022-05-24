import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/addPost.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class groupPosts extends StatefulWidget {
  final group grp;

  const groupPosts(this.grp);

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

              );
            }),
      ),
    );
  }
}

class postItem extends StatelessWidget {
  const postItem({Key key, this.pst, this.grp, this.removePst}) : super(key: key);
  final post pst;
  final group grp;
  final   Function removePst;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                heightFactor: 1.7,
                alignment: Alignment(-.9, 0),
                child: Text(pst.title, style: TextStyle(fontSize: 25)),
              ),
              Positioned(
                  right: -5,
                  child: Container(child: IconButton(icon: Icon(Icons.edit, size: 16,),
                      //if usere
                      onPressed: () {},
                    ),
                  )),
              Positioned(
                  right: 25,
                  child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                      //if usere
                  onPressed: () {
                    removePst();
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
              image: AssetImage(pst.imageURL),
            )),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              pst.caption,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.comment_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      //go to di
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 20,
                      ),
                      onPressed: () {
                      }),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(
                    Icons.face,
                    size: 20,
                  )),
                )
              ],
            ),
          )
        ],
      ),

      //title
      // image
      //caption
      //icons
    );
  }
}
