import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redit/post.dart';
import 'package:redit/postDetails.dart';
import 'package:redit/user.dart';
import 'group.dart';
import 'groupPosts.dart';

class savedPage extends StatefulWidget {
  const savedPage(this.savedPst, this.saveFromGrp, this.currentUser, this.unSave, this.removePstFeed, this.allPosts) ;
  final List<post> savedPst;
  final List<post> allPosts;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;
  final Function removePstFeed;
  

  @override
  State<savedPage> createState() => _savedPageState();
}

class _savedPageState extends State<savedPage> {
  @override
  void initState() {
    sortSaved();
    super.initState();
  }
  void unSave(int index){
    setState(() {
      widget.savedPst.remove(widget.savedPst[index]);
    });
  }
  void sortSaved(){
    final DateFormat formatter = DateFormat('yyyyMMdd');
    for(int i=0;i<widget.savedPst.length-1;i++){
      for(int j=0;j<widget.savedPst.length-1-i;j++) {
        if(int.parse(formatter.format(widget.savedPst[j].date)) < int.parse(formatter.format(widget.savedPst[j+1].date))){
          setState( () {
            post p=widget.savedPst[j];
            widget.savedPst[j]=widget.savedPst[j+1];
            widget.savedPst[j+1]=p;
          });
        }
      }
    }
  }
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
                saveFromGrp: widget.saveFromGrp,
                currentUser: widget.currentUser,
                unSave:()=> unSave(index),
                savedPst: widget.savedPst,
                removePstFeed: widget.removePstFeed,
                allPosts: widget.allPosts,
              );
            }),
      ),
    );
  }
}


class savedItem extends StatefulWidget {
  const savedItem({Key key, this.pst, this.saveFromGrp, this.currentUser, this.unSave, this.savedPst, this.removePstFeed, this.allPosts}) : super(key: key);
  final post pst;
  final Function saveFromGrp;
  final user currentUser;
  final Function unSave;
  final List<post> savedPst;
  final List<post> allPosts;
  final Function removePstFeed;


  @override
  State<savedItem> createState() => _savedItemState();
}

class _savedItemState extends State<savedItem> {
  bool isLiked=false;
  bool isDisliked=false;
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
  void unSave(post p){
      widget.savedPst.remove(p);
  }
  Map stringToMap(String str){
    List<String> arr=str.split(",,");
    Map<String,String> map = {};
    for(int i=0;i<arr.length;i++){
      int colon=arr[i].indexOf(":");
      String key=arr[i].substring(0,colon);
      String value=arr[i].substring(colon+1);
      map[key]=value;
    }
    return map;
  }
  List<post> gPosts=[];
  getGroupPosts(String name)async{
    print("to getGroupPosts");
    String request="getGroupPosts\nname:$name\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        String str=String.fromCharCodes(response);
        print("rsponse: $str");
        if(str!="\u0000") {
          List<String> arr = str.split("\n");
          var maps = <Map>[];
          print(arr.length);
          for (int i = 0; i < arr.length; i++) {
            maps.add(stringToMap(arr[i]));
          }
          gPosts = [];
          for (int i = 0; i < maps.length; i++) {
            post p = post(maps[i]["title"], maps[i]["caption"], maps[i]["image"], DateTime.parse(maps[i]["date"]), user(maps[i]["user"]), [], group(maps[i]["groupName"], user(maps[i]["groupAdmin"]), maps[i]["groupImage"]),int.parse(maps[i]["like"]),int.parse(maps[i]["dislike"]),int.parse(maps[i]["comment"]));
            setState(() {
              gPosts.add(p);
            });
          }
        }
        else
          gPosts=[];
        group chosenGrp=group(name, widget.pst.groupPublisher.admin, widget.pst.groupPublisher.imageURL,gPosts,widget.pst.groupPublisher.stared);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  groupPosts(chosenGrp,widget.currentUser,widget.saveFromGrp,widget.unSave,widget.savedPst,widget.removePstFeed,widget.allPosts)));
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
  sendUnSaved(String currentUser,String title,String caption,String image,String data,String user,String groupName,String groupAdmin,String groupImage ,String like,String dislike) async {
    print("sendingggg");
    String request="unSavePost\ncurrentUser:$currentUser,,title:$title,,caption:$caption,,image:$image,,date:$data,,user:$user,,groupName:$groupName,,groupAdmin:$groupAdmin,,groupImage:$groupImage,,like:$like,,dislike:$dislike\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }
  List<comment> comments=[];
  getComments(String title)async{
    print("to getGroupPosts");
    String request="getComments\ntitle:$title\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        String str=String.fromCharCodes(response);
        print("rsponse: $str");
        if(str!="\u0000") {
          List<String> arr = str.split("\n");
          var maps = <Map>[];
          print(arr.length);
          for (int i = 0; i < arr.length; i++) {
            maps.add(stringToMap(arr[i]));
          }
          comments = [];
          for (int i = 0; i < maps.length; i++) {
            comment c=comment(user(maps[i]["user"]), maps[i]["content"],int.parse(maps[i]["like"]),int.parse(maps[i]["dislike"]));
            setState(() {
              comments.add(c);
            });
          }
        }
        else
          comments=[];
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.pst.groupPublisher,widget.currentUser,isLiked,isDisliked,comments)));
 });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: (){
             getGroupPosts(widget.pst.groupPublisher.name);
            },
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
          Align(
            //heightFactor: 1.7,
              alignment: Alignment(-.9,0),
              child:  Text((DateFormat('yyyy-MM-dd kk:mm').format(widget.pst.date)),style: TextStyle(fontSize: 15,color: Colors.white70))
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
                      child: IconButton(
                          onPressed: (){
                            getComments(widget.pst.title);
                           // Navigator.push(context, MaterialPageRoute(builder: (context) =>  postDetails(widget.pst,widget.pst.groupPublisher,widget.currentUser,isLiked,isDisliked)));
                          },
                          icon: Icon(Icons.comment_outlined, size: 20,)

                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                      padding: EdgeInsets.only(left: 350),
                      child: IconButton(icon: Icon(Icons.save, size: 20,),
                        onPressed: (){
                        setState(() {
                          widget.unSave();
                          sendUnSaved(widget.currentUser.userName, widget.pst.title, widget.pst.caption, widget.pst.imageURL, widget.pst.date.toString(), widget.pst.userPublisher.userName, widget.pst.groupPublisher.name, widget.pst.groupPublisher.admin.userName, widget.pst.groupPublisher.imageURL,widget.pst.likesNum.toString(),widget.pst.disLikesNum.toString());
                        });
                        },
                      ),
                    ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
