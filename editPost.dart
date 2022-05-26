import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redit/post.dart';

class editPost extends StatefulWidget {
  const editPost(this.pst) ;
  final post pst;

  @override
  State<editPost> createState() => _editPostState();
}

class _editPostState extends State<editPost> {
  TextEditingController titleC;
  TextEditingController captionC;
  @override
  void initState() {
    titleC=TextEditingController();//captionC
    //titleC.text=widget.pst.title;
    captionC=TextEditingController();//captionC
    //captionC.text=widget.pst.caption;
    super.initState();
  }

  @override
  void dispose() {
    titleC.dispose();
    captionC.dispose();
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

              cursorColor: Colors.deepOrange.shade200,
              decoration: const InputDecoration(hintText: "Title"),
              controller: titleC,
              keyboardType: TextInputType.text,
            ),
            TextField(

              cursorColor: Colors.deepOrange.shade200,
              decoration: const InputDecoration(hintText: "Caption"),
              controller: captionC,
              keyboardType: TextInputType.text,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                width: 200,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange.shade200,onPrimary: Colors.black),
                  onPressed: (){
                    String title =titleC.text;//ok
                    String caption =captionC.text;
                    //print(titleC.text );
                    setState(() {
                      widget.pst.setTitle(title);//ok
                      //print(widget.pst.title);
                      widget.pst.setCaption(caption);
                    });
                    titleC.clear();
                    captionC.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Confirm',style: TextStyle(fontSize: 17),),
                )
            )
          ],
        ),
      ),
    );
  }
}
