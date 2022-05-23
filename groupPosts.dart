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
            child: Align(
              alignment: Alignment(-.9,0),
              child: Text(pst.title,style:TextStyle(fontSize: 25)),
            ),
            ),
          
          Image.asset(pst.imageURL),
          
          Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Text(pst.caption,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),

          Container(
            child: Row(
              children: [
                Container(
                  child: IconButton(icon: Icon(Icons.comment_outlined,size: 20,),onPressed: (){},),

                ),
                Container(
                  child: IconButton(icon: Icon(Icons.favorite,size: 20,),onPressed: (){}),
                ),
                Container(
                  child: IconButton(icon: Icon(Icons.face,size: 20,)),
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
