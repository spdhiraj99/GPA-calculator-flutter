import 'package:flutter/material.dart';
import './score_page.dart';
import 'dart:async';
class GPAcalc extends StatefulWidget {
  final int n;

  GPAcalc(this.n);

  @override
  GPAcalcstate createState() => new GPAcalcstate();
}

class GPAcalcstate extends State<GPAcalc> {
  List<String> _items = ['O', 'A+', 'A', 'B+', 'B', 'C', 'P', 'F/Ab/I'].toList();
  List<String> _itemsCp = ['1', '2', '3', '4', '5'].toList();
  var _selection;
  var _selectionCp;
  var list;

  @override
  void initState() {
    super.initState();
    _selection= new List<String>()..length=widget.n;
    _selectionCp= new List<String>()..length=widget.n;
    list = new List<int>.generate(widget.n, (i) =>i);
  }

  @override
  Widget build(BuildContext context) {
    int sogxc = 0, soc = 0;
    var textFields = <Widget>[];
    bool safeToNavigate=true;
    textFields.add(new Row(
      children: [
        new Padding(
          padding:new EdgeInsets.only(left: 96.0),
        ),
        new Column(
          children:[
            new Text(
              "Grade",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
            ),
          ]
        ),
        new Padding(
          padding:new EdgeInsets.only(left: 72.0),
        ),
        new Column(
          children:[
            new Text(
              "Credits",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
            ),
          ],
        ),
        new Padding(
          padding:new EdgeInsets.only(bottom:25.0),
        ),
      ]
      ),
    );
      list.forEach((i) {
          textFields.add( new Column(
                children: [
                  new Row(
                 //   mainAxisAlignment: MainAxisAlignment.center,
                   // crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    new Text("Subject ${i+1}:",style: new TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                    new Padding(
                      padding:new EdgeInsets.all(10.0),
                    ),
                    new DropdownButton<String>(
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      hint: new Text("grade ${i+1}",style:TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
                      value: _selection[i],
                      items: _items.map((String item) {
                        return new DropdownMenuItem<String>(
                          value: item,
                          child: new Text(item,textAlign: TextAlign.center,),
                        );
                      }).toList(),
                      onChanged: (s) {
                        setState(() {
                          _selection[i] = s;
                        });
                      },
                    ),
                    new Padding(
                      padding:new EdgeInsets.all(35.0),
                    ),
                     
                    new DropdownButton<String>(
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      hint: new Text("credit ${i+1}",style:TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),),
                      value: _selectionCp[i],
                      items: _itemsCp.map((String items) {
                        return new DropdownMenuItem<String>(
                          value: items,
                          child: new Text(items,textAlign: TextAlign.center,),
                        );
                      }).toList(),
                      onChanged: (s) {
                        setState(() {
                          _selectionCp[i] = s;
                        });
                      },
                    ),
                  ]
                  ),

                ],
              ),
          );
      });
        
    double res = 0.0;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("GPA calculator"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.orange[100],
      body: new Container(
        decoration: new BoxDecoration(border: new Border.all(color: Colors.transparent, width: 30.0)),
        child: new ListView(
          children: textFields,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Calculate',
        backgroundColor: Colors.deepOrangeAccent,
        child: new Icon(Icons.gavel),
        onPressed: () {
          for (int i = 0; i < widget.n; i++) {
            if(_selectionCp[i]==null){
              safeToNavigate = false;
              continue;
            }
            if(_selection[i]==null){
              safeToNavigate = false;
              continue;
            }
            int r = int.parse(_selectionCp[i]);
            int gp = calculate(_selection[i]);
            int cp = r;
            int gxc = gp * cp;
            sogxc += gxc;
            soc += cp;
          }
          res = sogxc / soc;
          if(safeToNavigate)
          Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ScorePage(res),
                ),
              );
          else{
            alert();
          }
        },
      ),
    );
  }

  int calculate(var a) {
    if (a == "O") return 10;
    if (a == "A+") return 9;
    if (a == "A") return 8;
    if (a == "B+") return 7;
    if (a == "B") return 6;
    if (a == "C") return 5;
    if (a == "P") return 4;
    if (a == "F/Ab/I") return 0;
    return 0;
  }
  Future<Null> alert() async {
  return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Rewind and remember'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('You have done something terrible.'),
              new Text('Go back and reflect on your mistakes.'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('give me one more chance'),
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