import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage2(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  int _counter = 0;
  String result='';
  final _currency=[ 'Doller' , 'Euro', 'Rupees' ];
  String _current='Doller';
  TextEditingController distance= new TextEditingController();
  TextEditingController distance_p_u= new TextEditingController();
  TextEditingController price= new TextEditingController();
  final double _formDistace= 5.0;


  @override
  void initState() {
    getData();
  }

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  void setTextmethod11(String value){
    setState(() {
      result=value;
    });

  }

  _onDropDownDownItemChanged(String v){
    setState(()=>_current=v);
  }

  Future getData() async{
    print("hello");
    String url="http://theaaquibnaseem.epizy.com/post.php";
      http.Response response=await http.get(url);
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        print(data.toString());

      }

  }

  String _calculate(){
    double _distance=double.parse(distance.text);
    double _distance_P_U=double.parse(distance_p_u.text);
    double _price=double.parse(price.text);
    double totolcost=_distance/_distance_P_U*_price;
    String result = "The Total amout of your journey is"+totolcost.toStringAsFixed(2) + '  '+ _current;
    return result;



  }
  void _Reset(){
    distance.text="";
    distance_p_u.text="";
    price.text="";
    setState(() {
      result="";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(20.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top:_formDistace,
                      bottom: _formDistace
                    ),
                    child: new TextField(
                      controller: distance,
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          hintText: 'E.g. 1234',
                          labelText: 'Distance',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )

                      ),
                      keyboardType: TextInputType.number,

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: _formDistace,
                      bottom: _formDistace
                    ),
                      child:new TextField(
                    controller: distance_p_u,
                    decoration: InputDecoration(
                        labelStyle: textStyle,
                        hintText: 'E.g. 1234',
                        labelText: 'Distance Per Unit',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )

                    ),
                    keyboardType: TextInputType.number,

                  )
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: _formDistace,
                                bottom: _formDistace
                            ),
                            child:new TextField(
                              controller: price,
                              decoration: InputDecoration(
                                  labelStyle: textStyle,
                                  hintText: 'E.g. 1234',
                                  labelText: 'Price',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )

                              ),
                              keyboardType: TextInputType.number,

                            )),
                      ),
                      Container(width: _formDistace*3,),
                      Expanded(
                        child: DropdownButton<String>(
                            items: _currency.map((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            value: _current,
                            onChanged: (String v){
                              _onDropDownDownItemChanged(v);
                            }
                        ),
                      )
                    ],
                  )




                ],
              ),

            ),
            /*new TextField(
              controller: distance,
              decoration: InputDecoration(
                labelStyle: textStyle,
                hintText: 'E.g. 1234',
                labelText: 'Distance',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )

              ),
              keyboardType: TextInputType.number,

            ),*/
            /*DropdownButton<String>(
                items: _currency.map((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                  );
                }).toList(),
                value: _current,
                onChanged: (String v){
                  _onDropDownDownItemChanged(v);
                }
            ),*/
            new Row(

              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                      left: _formDistace,

            ),
                      child:RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                      setState(()=>result=_calculate());
                    },
                    child: new Text("Submit"),
                  )),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: _formDistace,

                      ),
                      child:RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                    onPressed: (){
                      setState(()=>_Reset());
                    },
                    child: new Text("Reset"),
                  )),
                )
              ],
            ),


            new Text("${result}"),
          ],
        ),
      )
      );

       /*Container(
        padding: EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                labelText: "Write",
                  hintText:'username',

                ),
                onChanged: (String vall){
                  setState(() {
                    _val=vall;
                  });
                },
              ),
              DropdownButton<String>(
                items: ['Doller','Euro','Rupees'].map((String str){
                  return new DropdownMenuItem(
                    value: str,
                    child: new Text(str),
                  );
                }).toList(),


              ),
              Text('hello ::'+ _val)
            ],
          ),

        ),
      )*/
      /*Center(

        child: Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'hello world',
            ),
            *//*Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),*//*
          ],
        ),
      ),*/
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.

  }
}
