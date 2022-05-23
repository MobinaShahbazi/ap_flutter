import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class groupPosts extends StatefulWidget {
  final group grp;
  const groupPosts(this.grp) ;


  @override
  State<groupPosts> createState() => _groupPostsState();
}

class _groupPostsState extends State<groupPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
      ),

      body: Center(
        child: ListView.builder(
            itemCount: widget.grp.posts.length,
            itemBuilder:(contex,index){
              return postItem(
                pst: widget.grp.posts[index],
              );
            }
        ),
      ),
    );
  }
}

class postItem extends StatelessWidget {
  const postItem({Key key, this.pst}) : super(key: key);
  final post pst;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            child: Text(pst.title),
          ),
          //Image(image: AssetImage(pst.imageURL)),
          Image.asset(pst.imageURL),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(pst.caption,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),


        //title
        // image
        //caption
        //icons

    );
  }
}
