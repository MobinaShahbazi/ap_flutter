import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class postDetails extends StatefulWidget {
  const postDetails({Key key, this.pst}) : super(key: key);
  final post pst;

  @override
  State<postDetails> createState() => _postDetailsState();
}

class _postDetailsState extends State<postDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
      ),
      body:Container(
        //comment,...
      ),
    );
  }
}
