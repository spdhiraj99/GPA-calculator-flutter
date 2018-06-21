import 'package:flutter/material.dart';
import 'dart:async';
import './gpa_calc.dart';

class GPA extends StatefulWidget{
  @override
  GPAState createState() => new GPAState(); 
}
class GPAState extends State<GPA>{
  TextEditingController controller = new TextEditingController();
  int n;
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("GPA calculator"), backgroundColor: Colors.deepOrangeAccent),
      backgroundColor: Colors.orange[100],
      body: new Container(
        decoration: new BoxDecoration(border: new Border.all(color: Colors.transparent,width: 25.0),color: Colors.transparent),
        child: new ListView(
           children: <Widget>[
              new TextField(
                textAlign: TextAlign.center,
                autofocus: true,

                decoration: new InputDecoration(
                  fillColor: Colors.deepOrangeAccent,
                  
                  hintText: "How many subjects did you have ",
                  hintStyle: new TextStyle(color: Colors.black54)
                ),
                keyboardType: TextInputType.number,
                controller: controller,
                onChanged: (String str){
                  setState((){
                    if(controller.text=="")
                      n=0;
                    n=int.parse(controller.text);
                  });
                },
              ),
              new IconButton(
                icon:new Icon(Icons.arrow_forward),
                onPressed: (){
                  if(n is int && n>0){
                    int pass=n;
                    n=0;
                    controller.text="";
                    Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new GPAcalc(pass)));
                  }
                  else{
                    controller.text="";
                    alert();
                  }
                },
              )
            ],
          ),
        ),
    );
  }
  Future<Null> alert() async {
  return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('rewind and regret fool !'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('You think you are smart?.'),
              new Text('Guess what... you are not.'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
