import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

import 'editPost.dart';
import 'group.dart';
import 'groupPosts.dart';

class feed extends StatefulWidget {
  const feed(this.postList, this.savedPst, this.allPst);
  final List<post> postList;
  final List<post> savedPst;
  final List<post> allPst;

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  void removePst(int index){
    setState(() {
      widget.allPst.remove(widget.allPst[index]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.postList.length,
            itemBuilder: (contex, index) {
              return feedItem(
                pst: widget.postList[index],
                savedPst: widget.savedPst,
                allPst: widget.allPst,
                removePst: ()=> removePst(index),
              );
            }),
      ),
    );
  }
}

class feedItem extends StatefulWidget {
  const feedItem({Key key, this.pst, this.savedPst, this.allPst, this.removePst}) : super(key: key);
  final post pst;
  final List<post> savedPst;
  final List<post> allPst;
  final Function removePst;

  @override
  State<feedItem> createState() => _feedItemState();
}

class _feedItemState extends State<feedItem> {

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
                        MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.savedPst))
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
                      //savePost(widget.pst);
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




