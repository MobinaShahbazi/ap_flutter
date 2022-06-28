import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/user.dart';


class groupPosts extends StatefulWidget {
  const groupPosts(this.grp,this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.savedPost, this.removePstFeed, this.allPosts);
  final group grp;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSaveFromGrp;
  final List<post> savedPost;
  final Function removePstFeed;
  final List<post> allPosts;






  @override
  State<groupPosts> createState() => _groupPostsState();
}

class _groupPostsState extends State<groupPosts> {

  @override
  void initState() {
    sortGrp(widget.grp);
    super.initState();
  }
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
  void unsave1(int index){
    widget.savedPost.remove(widget.savedPost[index]);
  }
  String groupName='';
  @override
  void sortGrp(group g){
    setState(() {
      final DateFormat formatter = DateFormat('yyyyMMdd');
      for(int i=0;i<g.posts.length-1;i++){
        for(int j=0;j<g.posts.length-1-i;j++) {
          if(int.parse(formatter.format(g.posts[j].date)) < int.parse(formatter.format(g.posts[j+1].date))){
            setState( () {
              post p=g.posts[j];
              g.posts[j]=g.posts[j+1];
              g.posts[j+1]=p;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.grp.imageURL),
        ),
        title: Text(widget.grp.name, style: TextStyle(fontSize: 20,),),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.grp.posts.length,
            itemBuilder: (contex, index) {
              return postItem(
                pst: widget.grp.posts[index],
                grp: widget.grp,
                removePst: ()=> removePstGrp(index),
                currentUser: widget.currentUser,
                saveFromGrp: widget.saveFromGrp,
                unSaveFromGrp: widget.unSaveFromGrp,
                unSave1: ()=> unsave1(index),
                removePstFeed: widget.removePstFeed,
                allPosts: widget.allPosts,
              );
            }),
      ),

    );
  }
}

class postItem extends StatefulWidget {
  const postItem({Key key, this.pst, this.grp, this.removePst, this.currentUser, this.saveFromGrp, this.unSaveFromGrp, this.unSave1, this.removePstFeed, this.allPosts,}) : super(key: key);
  final post pst;
  final group grp;
  final Function removePst;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function unSave1;
  final user currentUser;
  final Function removePstFeed;
  final List<post> allPosts;

  @override
  State<postItem> createState() => _postItemState();
}

class _postItemState extends State<postItem> {
  static const snackBar = SnackBar(content: Text('Access denied'),);

  bool isLiked=false;
  bool isDisliked=false;

  int indexOfPdt(post p){
    int index=0;
    for(int i=0;i<widget.allPosts.length;i++){
      if(p.title==widget.allPosts[i].title && p.caption==widget.allPosts[i].caption ){
        index=i;
      }
    }
    return index;
  }
  void like(){
    if(!isLiked) {
      int num = widget.pst.likesNum;
      num--;
      setState(() {
        widget.pst.setlikesNum(num);
      });
    }
    else {
      int num = widget.pst.likesNum;
      num++;
      setState(() {
        widget.pst.setlikesNum(num);
      });
      if(isDisliked) {
        int num = widget.pst.disLikesNum;
        num--;
        setState(() {
          widget.pst.setDislikesNum(num);
        });
        isDisliked=!isDisliked;
      }
    }
  }
  void dislike(){
    if(!isDisliked) {
      int num = widget.pst.disLikesNum;
      num--;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
    }
    else {
      int num = widget.pst.disLikesNum;
      num++;
      setState(() {
        widget.pst.setDislikesNum(num);
      });
      if(isLiked) {
        int num = widget.pst.likesNum;
        num--;
        setState(() {
          widget.pst.setlikesNum(num);
        });
        isLiked=!isLiked;
      }
    }
  }
  bool isEqual(user u1,user u2){
    if(u1.userName == u2.userName)
      return true;
    else
      return false;
  }
  bool isSaved=false;
  sendSaved(String currentUser,String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike) async {
    print("$groupName");
    String request="savePost\nlike:$like,,dislike:$dislike,,groupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,currentUser:$currentUser,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user\u0000";
    print("req: $request");
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print("ans:${String.fromCharCodes(response)}");
      });
    });
  }
  resetLike(String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike) async {
    print("sendingggg");
    String request="likeDislike\ngroupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,like:$like,,dislike:$dislike,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user\u0000";
    print("request: $request");
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  removePost(String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike) async {
    print("sendingggg");
    String request="removePost\ngroupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,like:$like,,dislike:$dislike,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user\u0000";
    print("request: $request");
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  void removePstFeed(int index){
    setState(() {
      widget.allPosts.remove(widget.allPosts[index]);
      // print("removeeeeeeeeeeeee");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 10,
          ),
          Stack(
            children: [
              Column(
                children: [
                  Align(
                    //heightFactor: 1,
                    alignment: Alignment(-.9,0),
                    child: Text(widget.pst.title, style: TextStyle(fontSize: 25)),
                  ),
                  Align(
                    //heightFactor: 1.7,
                      alignment: Alignment(-.9,0),
                    child:  Text((DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date)),style: TextStyle(fontSize: 15,color: Colors.white70))
                  ),
                ],
              ),
              Positioned(
                  right: -5,
                  child: Container(child: IconButton(icon: Icon(Icons.delete, size: 16,),
                    //if usere
                    onPressed: () {
                      if(isEqual(widget.currentUser, widget.grp.admin)){
                        removePost(widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString());
                        widget.removePst();
                        removePstFeed(indexOfPdt(widget.pst));
                      }
                      else
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      child: IconButton(icon: Icon(isLiked ?Icons.thumb_up:Icons.thumb_up_alt_outlined , size: 20,),
                        onPressed: () {
                          setState(() {
                            isLiked = ! isLiked;
                          });
                          like();
                          resetLike(widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString());
                        },
                      ),
                    ),
                    Container(
                      child: Text('${widget.pst.likesNum-widget.pst.disLikesNum}'),
                    ),
                    Container(
                      child: IconButton(icon: Icon(isDisliked?Icons.thumb_down:Icons.thumb_down_alt_outlined, size: 20,),
                          onPressed: () {
                            setState(() {
                              isDisliked = ! isDisliked;
                            });
                            dislike();
                            resetLike(widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString());
                          }),
                    ),
                    Container(
                      child: IconButton(icon: Icon(Icons.comment_outlined, size: 20,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.grp,widget.currentUser,isLiked,isDisliked)));
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(isSaved? Icons.save:Icons.save_outlined, size: 20,),
                        onPressed: (){
                        setState(() {
                          isSaved=!isSaved;
                        });
                        if(isSaved){
                          sendSaved(widget.currentUser.userName, widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString());
                          widget.saveFromGrp(widget.pst,widget.grp);
                        }
                        else{
                          widget.unSave1();
                        }
                        },
                      ),
                    )
                )
              ],
            )
          ),
          Container(
            height: .7,
            width: 300,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }
}

