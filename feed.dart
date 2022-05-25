import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

import 'groupPosts.dart';

class feed extends StatefulWidget {
  const feed(this.postList, this.savedPst);
  final List<post> postList;
  final List<post> savedPst;

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {


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
              );
            }),
      ),
    );
  }
}

class feedItem extends StatefulWidget {
  const feedItem({Key key, this.pst, this.savedPst}) : super(key: key);
  final post pst;
  final List<post> savedPst;

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
          Container(
            child: ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.savedPst))
                );
                //go to groupPosts
              },
              title: Text(widget.pst.groupPublisher.name),
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.pst.groupPublisher.imageURL),
              ),
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




