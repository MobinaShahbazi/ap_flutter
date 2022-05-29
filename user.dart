import 'package:flutter/src/widgets/image.dart';
import 'package:redit/group.dart';
import 'package:redit/post.dart';

class user{
  String _userName;
  String _password;
  String _email;
  //List<post>  saved=[];

  user(this._userName,this._password);

  String get userName =>_userName;
  void setUserName(String val){
    _userName=val;
  }
  String get password =>_password;
  void setPassword(String val){
    _password=val;
  }
  String get email =>_email;
  void setEmail(String val){
    _email=val;
  }
}