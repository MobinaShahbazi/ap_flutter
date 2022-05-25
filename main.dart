import 'package:flutter/material.dart';
import 'package:redit/addGroup.dart';
import 'package:redit/addPost.dart';
import 'package:redit/editPost.dart';
import 'package:redit/groupPart.dart';
import 'logIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      theme: ThemeData.dark(),
      home: groupList(),
    );
  }
}


