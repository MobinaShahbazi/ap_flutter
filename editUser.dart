import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:redit/post.dart';
import 'package:redit/user.dart';

class editUser extends StatefulWidget {
  const editUser(this.currentUser, this.users, this.addGrp, this.savedPst, this.saveFromGrp, this.unSaveFromGrp, this.setCurrentUser, this.changeUser) ;
  final Function addGrp;
  final List<post> savedPst;
  final user currentUser;
  final List<user> users;
  final Function saveFromGrp;
  final Function unSaveFromGrp;
  final Function setCurrentUser;
  final Function changeUser;



  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  static const snackBar = SnackBar(content: Text('This username has been used before',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);
  static const snackBar2 = SnackBar(content: Text('Invalid Password',style: TextStyle(fontSize: 16),), backgroundColor: (Colors.grey),);
  TextEditingController userNameC;
  TextEditingController passC;
  TextEditingController emailC;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userNameC=TextEditingController();
    userNameC.text=widget.currentUser.userName;
    passC=TextEditingController();
    passC.text=widget.currentUser.password;
    emailC=TextEditingController();
    emailC.text=widget.currentUser.email;
    super.initState();
  }
  @override
  void dispose() {
    userNameC.dispose();
    passC.dispose();
    emailC.dispose();
    super.dispose();
  }
  isRepetitive(String name,String pass,String email) async {
    final form = formKey.currentState;
    String request="isRepetitive\nuserName:$name,,password:$pass,,email:$email\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      if(!isValidPass(pass)){
        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      }
      if (form.validate() && isValidPass(pass)) {
        serverSocket.write(request);
      }
      serverSocket.flush();
      serverSocket.listen((response) {
        if(String.fromCharCodes(response)=="repetitive\u0000"){
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if(form.validate() && isValidPass(pass) && String.fromCharCodes(response)=="new userName\u0000") {
          editUsr(widget.currentUser.userName,userNameC.text,passC.text,emailC.text);
          String userName = userNameC.text;
          String pass = passC.text;
          String email = emailC.text;
          setState(() {
            widget.changeUser(0,userName,pass,email);
          });
          userNameC.clear();
          passC.clear();
          emailC.clear();
          Navigator.pop(context);
        }
      });
    });
  }
  editUsr(String preUserName,String userName ,String password,String email) async {
    print("sendingggg");
    String request="editUser\npreUserName:$preUserName,,userName:$userName,,password:$password,,email:$email\u0000";
    await Socket.connect("192.168.56.1",3000).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response) {
        print(String.fromCharCodes(response));
      });
    });
  }

  bool isValidPass(String str) {
    RegExp Rg = new RegExp(r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$');
    if (Rg.hasMatch(str))
      return true;
    else
      return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Container(
        //padding: EdgeInsets.all(50),
        padding: EdgeInsets.all(50),
        child: Form(
          key: formKey,
          child: Column(
        children: [
        TextField(
        cursorColor: Colors.teal,
          decoration: const InputDecoration(hintText: "User Name"),
          controller: userNameC,
          keyboardType: TextInputType.text,
        ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 2, right: 2),
            child: PasswordField(
              passwordConstraint: r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$',
              controller: passC,
              inputDecoration: PasswordDecoration(),
              hintText: 'at least 8 characters',
              border: PasswordBorder(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade200),
                  )),
              errorMessage: 'must contains small and capital and numbers\$',
            ),
          ),
        Padding(
          padding: EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
          child: EmailFieldWidget(controller: emailC),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
          width: 120,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange.shade200,onPrimary: Colors.black),
            onPressed: () {
              final form = formKey.currentState;
              isRepetitive(userNameC.text,passC.text,emailC.text);
              // if(!isValidPass(passC.text)){
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar2);
              // }
              // else if(form.validate() && isValidPass(passC.text) && !usedBefore(userNameC.text)) {
              //   String userName = userNameC.text;
              //   String pass = passC.text;
              //   String email = emailC.text;
              //   setState(() {
              //     widget.changeUser(0,userName,pass,email);
              //   });
              //   userNameC.clear();
              //   passC.clear();
              //   emailC.clear();
              //   Navigator.pop(context);
              // }
            },
            child: const Text("Confirm",style: TextStyle(fontSize: 17)),),
          // color: Colors.teal,
        )

        ],
      ),
        ),
      ),
    );
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
