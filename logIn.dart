import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'appColor.dart';
import 'package:redit/user.dart';
import 'feed.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _mainScaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<user> users=[user('','',''),user('ali','111'),user('mahsa','12')];
  user currentUser=user('', '','');
  void setCurrentUser(String u,String p,String e){
    setState(() {
      currentUser.setUserName(u);
      currentUser.setPassword(p);
      currentUser.setEmail(e);
    });
  }
  static const snackBar = SnackBar(content: Text('incorrect password',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);
  static const snackBar2 = SnackBar(content: Text('invalid',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);

  bool correctPass(String name,String pass){
    int index=0;
    for(int i=0;i<users.length;i++){
      if(users[index].userName==name)
      {
        index=i;
        break;
      }
      index++;
    }
    if(users[index].password==pass)
      return true;
    else
      return false;
  }
  String validate="";
  get(String name,String pass)async{
    String request="login\nuserName:$name,,password:$pass\u0000";
    await Socket.connect("192.168.56.1", 3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        setState(() {
          validate=String.fromCharCodes(response);
          print(validate);
          if(validate=="invalid\u0000"){
            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
          }
          else if(validate=="wrong pass\u0000"){
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => feed(currentUser,users,setCurrentUser) ));
          }
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        key: _mainScaffoldKey,
        body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none, alignment: Alignment.topCenter,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        color: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          width: 360.00,
                          height: 440.00,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                child: TextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(fontFamily: "SignikaSemiBold", fontSize: 16.0, color: Colors.black),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter userName",
                                      hintStyle: TextStyle(fontFamily: "SignikaSemiBold", fontSize: 18.0)),
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                child: TextField(
                                  focusNode: focusPassword,
                                  controller: passwordController,
                                  style: TextStyle(fontFamily: "SignikaSemiBold", fontSize: 16.0, color: Colors.black),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter password",
                                      hintStyle: TextStyle(
                                          fontFamily: "SignikaSemiBold", fontSize: 18.0)),
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 60.0, bottom: 26.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(color: AppColours.colorStart, offset: Offset(1.0, 6.0), blurRadius: 20.0),
                                      BoxShadow(color: AppColours.colorEnd, offset: Offset(1.0, 6.0), blurRadius: 20.0),
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          AppColours.colorEnd,
                                          AppColours.colorStart
                                        ],
                                        begin: const FractionalOffset(0.2, 0.2),
                                        end: const FractionalOffset(1.0, 1.0),
                                        stops: [0.1, 1.0],
                                        tileMode: TileMode.clamp)),
                                child: MaterialButton(
                                    color: Colors.deepOrange.shade200,
                                    highlightColor: Colors.deepOrange.shade300,
                                    splashColor: AppColours.colorEnd,
                                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                                      child: Text("Login", style: TextStyle(fontFamily: "SignikaSemiBold", color: Colors.black, fontSize: 22.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      // if(!correctPass(nameController.text,passwordController.text))
                                      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      // else if(correctPass(nameController.text,passwordController.text)){
                                      //   currentUser=user(nameController.text, passwordController.text);
                                      get(nameController.text, passwordController.text);

                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: FlatButton(
                      child: Text("Not have account?", style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: "SignikaRegular"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        gradient: LinearGradient(
                            colors: [Colors.white, Colors.white],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(0.5, 0.5),
                            stops: [0.1, 0.5],
                            tileMode: TileMode.clamp)),
                    child: MaterialButton(
                      color: Colors.deepOrange.shade200,
                      highlightColor: Colors.deepOrange.shade300,
                      splashColor: Colors.white70,
                      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                        child: Text("SignUp", style: TextStyle(fontFamily: "SignikaSemiBold", color: Colors.black, fontSize: 22.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpWidget(users1:users,currentUser: currentUser,setCurrentUser: setCurrentUser,)));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.white10,
                                  Colors.white,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: 100.0,
                          height: 1.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white10,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: 100.0,
                          height: 1.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key key, this.users1, this.currentUser, this.setCurrentUser}) : super(key: key);
  final List<user> users1;
  final  user currentUser;
  final Function setCurrentUser;

  @override
  State<SignUpWidget> createState()=> SignUpState();

}
class SignUpState extends State<SignUpWidget> {

  final FocusNode focusName = FocusNode();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const snackBar = SnackBar(content: Text('This username has been used before',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey));
  bool addOrNot=false;
  bool usedBefore(String name){
    for(int i=0;i<widget.users1.length;i++)
    {
      if(widget.users1[i].userName==name)
        return true;
    }
    return false;
  }
  void addUser(user us){
    widget.users1.add(us);
    addOrNot=true;
  }
  @override
  void dispose() {
    super.dispose();
  }
  bool isValidOrnot(String str) {
    RegExp Rg = new RegExp(r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$');
    if (Rg.hasMatch(str))
      return true;
    else
      return false;
  }
  send(String name,String pass,String email) async {
    final form = formKey.currentState;
    String request="signUp\nuserName:$name,,password:$pass,,email:$email\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      if (form.validate() && isValidOrnot(pass)) {
        serverSocket.write(request);
      }
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
        if (form.validate() && isValidOrnot(pass))  {
          if (String.fromCharCodes(response) == "new userName\u0000") {
              widget.setCurrentUser(nameController.text, passwordController.text, emailController.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) => feed(widget.currentUser, widget.users1, widget.setCurrentUser)));
          }
          else if (String.fromCharCodes(response) == "repetitive\u0000") {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Container(
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          color: Colors.grey.shade700,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                            width: 360.00,
                            height: 480.00,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                  child: TextField(
                                    focusNode: focusName,
                                    controller: nameController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter name", hintStyle: TextStyle(fontFamily: "SignikaSemiBold", fontSize: 18.0)),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                  child: EmailFieldWidget(controller: emailController),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                  child: PasswordField(
                                    passwordConstraint: r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$',
                                    controller: passwordController,
                                    inputDecoration: PasswordDecoration(),
                                    hintText: 'at least 8 characters',
                                    border: PasswordBorder(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red.shade200),
                                        )),
                                    errorMessage: 'must contains small and capital and numbers\$',
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 40.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: AppColours.colorStart,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0),
                                        BoxShadow(
                                            color: AppColours.colorEnd,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0),
                                      ],
                                      gradient: LinearGradient(
                                          colors: [
                                            AppColours.colorEnd,
                                            AppColours.colorStart
                                          ],
                                          begin:
                                          const FractionalOffset(0.2, 0.2),
                                          end: const FractionalOffset(1.0, 1.0),
                                          stops: [0.1, 1.0],
                                          tileMode: TileMode.clamp)),
                                  child: MaterialButton(
                                    color: Colors.deepOrange.shade200,
                                    highlightColor: Colors.deepOrange.shade300,
                                    splashColor: AppColours.colorEnd,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 42.0),
                                      child: Text("Sign Up", style: TextStyle(fontFamily: "SignikaSemiBold", color: Colors.white, fontSize: 22.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      send(nameController.text,passwordController.text,emailController.text);

                                      // final form = formKey.currentState;
                                      // if (form.validate()) {
                                      //   if(!usedBefore(nameController.text) && form.validate()&& isValidOrnot(passwordController.text))
                                      //     addUser(new user(nameController.text,passwordController.text,emailController.text));
                                      //   if(!addOrNot)
                                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      //   if (isValidOrnot(passwordController.text) && addOrNot){
                                      //     send(nameController.text,passwordController.text,emailController.text);
                                      //     widget.setCurrentUser(nameController.text,passwordController.text,emailController.text);
                                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => feed(widget.currentUser,widget.users1,widget.setCurrentUser) ));
                                      //   }
                                      // }

                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.white10,
                                    Colors.white,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            width: 100.0,
                            height: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({Key key, this.controller}) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    decoration: InputDecoration(
      hintText: 'Email',
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (email) =>
    !EmailValidator.validate(email) ? 'Enter a valid email' : null,
  );
}
