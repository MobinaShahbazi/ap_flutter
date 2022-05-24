import 'package:flutter/cupertino.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

class group{
  String _name;
  String _imageURL;
  user _admin;
  //List<user> members=[]; ??
  List<post> posts=[];

  group(this._name, this._admin,this._imageURL,this.posts);

  String get imageURL =>_imageURL;
  set setImageURL(String val){
    _imageURL=val;
  }
  String get name =>_name;
  set setTitle(String val){
    _name=val;
  }
  user get admin =>_admin;
  set setAdmin(user val) {
    _admin = val;
  }
}