import 'dart:ui';
import 'package:redit/group.dart';
import 'package:redit/user.dart';

class post{
  String _imageURL;
  String _title;
  String _caption;
  group _groupPublisher;
  user _userPublisher;
  DateTime _date;
  int _likesNum=0;
  int _disLikesNum=0;
  int _score=0;
  int _commentsNum=0;
  List<comment> comments=[];

  post(this._title,this._caption,this._imageURL,this._date,this._userPublisher,[this.comments,this._groupPublisher,this._likesNum,this._disLikesNum,this._commentsNum]);

  String get imageURL =>_imageURL;
  void setImageURL(String val){
    _imageURL=val;
  }
  String get title =>_title;
  void setTitle(String val){
    _title=val;
  }
  String get caption =>_caption;
  void setCaption(String val){

    _caption=val;
  }
  group get groupPublisher =>_groupPublisher;
  set setGroupPublisher(group val){
    _groupPublisher=val;
  }
  user get userPublisher =>_userPublisher;
  set setUserPublisher(user val){
    _userPublisher=val;
  }
  DateTime get date =>_date;
  set setDate(DateTime val){
    _date=val;
  }

  int get likesNum => _likesNum;
  void setlikesNum(int val){
    _likesNum=val;
  }

  int get score => _score;
  void setScore(int val){
    _score=val;
  }

  int get disLikesNum => _disLikesNum;
  void setDislikesNum(int val){
    _disLikesNum=val;
  }

  int get commentsNum => _commentsNum;
  void setCommentsNum(int val){
    _commentsNum=val;
  }




}
class comment{
  user _commentOwner;
  String _content;
  int _likesNum=0;
  int _disLikesNum=0;

  comment(this._commentOwner,this._content,[this._likesNum,this._disLikesNum]);

  String get content =>_content;
  set setContent(String val){
    _content=val;
  }
  int get likesNum => _likesNum;
  void setLikesNum(int val){
    _likesNum=val;
  }
  int get disLikesNum => _disLikesNum;
  void setDislikesNum(int val){
    _disLikesNum=val;
  }
  user get commentOwner =>_commentOwner;
  set setCommentOwner(user val){
    _commentOwner=val;
  }
}