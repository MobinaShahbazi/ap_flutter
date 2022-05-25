import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class feed extends StatefulWidget {
  const feed(this.groups);
  final List<group> groups;



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
            itemCount: widget.groups.length,
            itemBuilder: (contex, index) {
              //return
            }),
      ),
    );
  }
}

class feedItem extends StatefulWidget {
  const feedItem({Key key}) : super(key: key);

  @override
  State<feedItem> createState() => _feedItemState();
}

class _feedItemState extends State<feedItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




