import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/user.dart';

class editUser extends StatefulWidget {
  const editUser(this.currentUser) ;
  final user currentUser;

  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  TextEditingController userNameC;
  TextEditingController passC;
  TextEditingController emailC;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit'),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.teal,
              decoration: const InputDecoration(hintText: "User Name"),
              controller: userNameC,
              keyboardType: TextInputType.text,
            ),
            TextField(
              cursorColor: Colors.teal,
              decoration: const InputDecoration(hintText: "Password"),
              controller: passC,
              keyboardType: TextInputType.text,
            ),
            TextField(
              cursorColor: Colors.teal,
              decoration: const InputDecoration(hintText: "Email"),
              controller: emailC,
              keyboardType: TextInputType.text,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
              width: 120,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    String userName =userNameC.text;
                    String pass =passC.text;
                    String email =emailC.text;
                    setState(() {
                      //if ha
                      widget.currentUser.setUserName(userName);
                      widget.currentUser.setPassword(pass);
                      widget.currentUser.setEmail(email);
                    });
                    userNameC.clear();
                    passC.clear();
                    emailC.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm")),
              // color: Colors.teal,
            )

          ],
        ),

      ),



    );
  }
}
