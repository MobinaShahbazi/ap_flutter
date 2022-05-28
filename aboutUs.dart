import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reddit"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/contact1.jpg'),
                  )),
            ),
            //Image.asset('assets/contact1.jpg'),
            Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10,top: 20),
                    child: Icon(Icons.email,size: 23,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30,top: 20,),
                    child: Text('Contact us through this email:',style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10,top: 30),
              child: Text('shahbazi.mbn@gmail.com',style: TextStyle(fontSize: 15),),
            )
          ],
        ),

      ),
    );
  }
}
