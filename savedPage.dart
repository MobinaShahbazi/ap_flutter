import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class savedPage extends StatefulWidget {
  const savedPage(this.savedPst) ;
  final List<post> savedPst;

  @override
  State<savedPage> createState() => _savedPageState();
}

class _savedPageState extends State<savedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.savedPst.length,
            itemBuilder: (contex, index) {
              return savedItem(
                pst: widget.savedPst[index],
              );
            }),
      ),
    );
  }
}


class savedItem extends StatefulWidget {
  const savedItem({Key key, this.pst}) : super(key: key);
  final post pst;
  @override
  State<savedItem> createState() => _savedItemState();
}

class _savedItemState extends State<savedItem> {
  @override
  Widget build(BuildContext context) {
    int vote;
    return Container(
      child: Column(
        children: [
          ListTile(
            // onTap: (){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) =>  groupPosts(widget.pst.groupPublisher,widget.savedPst,widget.allPst,widget.gList,widget.addGrp))
            //   );
            //   //go to groupPosts
            // },
            title: Text(widget.pst.groupPublisher.name,style: TextStyle(fontSize: 22),),
            leading: CircleAvatar(backgroundImage: AssetImage(widget.pst.groupPublisher.imageURL),
            ),
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
              ],
            ),

          )



        ],
      ),
    );
  }
}
