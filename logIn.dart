import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:redit/groupPart.dart';
import 'appColor.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _mainScaffoldKey =
      new GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      width: 360.00,
                      height: 440.00,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              // focusNode: ,
                              //controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  // border: InputBorder.none,
                                  border: OutlineInputBorder(),
                                  hintText: "Enter userName",
                                  hintStyle: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 18.0)),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: focusPassword,
                              controller: passwordController,
                              style: TextStyle(
                                  fontFamily: "SignikaSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 18.0)),
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
                                    begin: const FractionalOffset(0.2, 0.2),
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
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      color: Colors.black,
                                      fontSize: 22.0),
                                ),
                              ),
                              onPressed: () {
                                //if valid
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => groupList() ));
                              }
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: "SignikaRegular"),
                              ),
                              onPressed: () {
                                displaySnackBar("Forgot clicked");
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
                child: FlatButton(
                  child: Text(
                    "Not have account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: "SignikaRegular"),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontFamily: "SignikaSemiBold",
                          color: Colors.black,
                          fontSize: 22.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpWidget()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
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

  void displaySnackBar(String value) {
    _mainScaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: "SignikaRegular"),
      ),
      backgroundColor: Colors.deepOrange.shade200,//////////////////////////////////////////////////////////////////////////////////////
      duration: Duration(seconds: 3),
    ));
  }
}
//Widget for input

class SignUpWidget extends StatefulWidget {
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpWidget> {
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusName = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  //final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool isValidOrnot(String str) {
    RegExp Rg = new RegExp(r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$');
    if (Rg.hasMatch(str))
      return true;
    else
      return false;
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
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: TextField(
                                    focusNode: focusName,
                                    controller: nameController,
                                    keyboardType: TextInputType.emailAddress,

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter name",
                                        hintStyle: TextStyle(
                                            fontFamily: "SignikaSemiBold",
                                            fontSize: 18.0)),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: EmailFieldWidget(
                                      controller: emailController),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: PasswordField(
                                    passwordConstraint:
                                        r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9]).{8,}$',
                                    controller: passwordController,
                                    inputDecoration: PasswordDecoration(),
                                    hintText: 'at least 8 characters',
                                    //color: Colors.deepOrange.shade300,
                                    border: PasswordBorder(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.shade200),
                                    )),
                                    errorMessage:
                                        'must contains small and capital and numbers\$',
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
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontFamily: "SignikaSemiBold",
                                            color: Colors.white,
                                            fontSize: 22.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      final form = formKey.currentState;
                                      if (form.validate()) {
                                        final email = emailController.text;
                                        if (!isValidOrnot(
                                            passwordController.text))
                                          print('hi');

                                          //if valid
                                          // add to users
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => groupList() ));

                                      }
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
