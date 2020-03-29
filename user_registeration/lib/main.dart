import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController name=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  bool visible=false;
  String name1;
  final double formdistance=5.0;

  Future userRegister() async{
    setState(() {
      visible=true;
    });

     name1=name.text;
    String email1=email.text;
    String password1=password.text;

    print(name1+""+email1+""+password1);



    var url="http://theaaquibnaseem.epizy.com/user_register.php";
    var data ={
      "Name":name1,
      "Email":email1,
      "Password":password1
    };
    print(json.encode(data)+"");

    var response = await http.post(url,body: json.encode(data));

    var msg=json.decode(response.body);



    if(response.statusCode==200){
      setState(() {
        visible=false;
      });
    }

    showDialog(
        context: context,
      builder: (BuildContext contex){
          return AlertDialog(
            title: new Text(msg),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=>Navigator.pop(contex),
                child:new Text("ok") ,
              )
            ],
          );
      }
    );



  }



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( child:new Container(
        padding: EdgeInsets.all(20.0),
          child:Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:EdgeInsets.only(
                top: formdistance,
                bottom: formdistance
              ),
                child:TextField(

              controller:name ,

              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.red,

                ),
                labelText: "Write Somethng",
                hintText: "Enter your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),

            )),
            Padding(
                padding:EdgeInsets.only(
                    top: formdistance,
                    bottom: formdistance
                ),
                child:TextField(

                  controller:email ,

                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Colors.red
                      ),
                      labelText: "Write Somethng",
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),

                )),
            Padding(
                padding:EdgeInsets.only(
                    top: formdistance,
                    bottom: formdistance
                ),
                child:TextField(

                  controller:password ,

                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Colors.red
                      ),
                      labelText: "Write Somethng",
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),

                )),


            Text(""),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Visibility(
              visible: visible,
              child: Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      )
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: userRegister,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
