import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prefs/prefs.dart';

void main() {
  runApp(MaterialApp(title: "Wifi Check", home: MyPage()));
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _tryAgain;
  TextEditingController pass=TextEditingController();
  SharedPreferences sh;

  @override
  void initState() {
    _checkWifi();
    super.initState();

  }

  _checkWifi() async {
    var sh= await SharedPreferences.getInstance();
    //sh.setBool("counter", _tryAgain);
    setState(() {
      bool val=sh.getBool('counter');
      this.sh=sh;
      if (val==null) {
        Future.delayed(Duration.zero,()=>_showAlert(context));
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    var body = Container(
      alignment: Alignment.center,
      child: _tryAgain
          ? RaisedButton(
          child: Text("Try again"),
          onPressed: () {
            _checkWifi();
          })
          : Text("This device is connected to Wifi"),
    );

    return Scaffold(
        appBar: AppBar(title: Text("Wifi check")),
        body: body
    );
  }

  void _showAlert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "Rflutter example",
       content: Form(
         child: Column(
           children: <Widget>[
             TextFormField(
               decoration: InputDecoration(
                 labelText: "Passwords",
               ),
             ),

           ],
         ),
       ),
       buttons: [
         DialogButton(
           child: Text("Save"),
           onPressed: (){
             setState(() {
               _tryAgain=false;
               sh.setBool('counter', _tryAgain);
               bool v=sh.getBool("counter");
             });

             debugPrint("$v");
             Navigator.pop(context);
           },
         )
        ]
    ).show();
    /*showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Wifi"),
          content: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirm passowrd"
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("ok"),
              onPressed: ()=>setState(() {
                Navigator.pop(context);
              }),
            )
          ],
        )
    );*/
  }
}
