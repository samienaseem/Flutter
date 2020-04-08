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
  /*String _haveStarted3Times = '';

  @override
  void initState() {
    super.initState();
    _incrementStartup();
  }

  /// Will get the startupnumber from shared_preferences
  /// will return 0 if null
  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  /// Reset the counter in shared_preferences to 0
  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 0);
  }

  /// Will Increment the startup number and store it then
  /// use setState to display in the UI
  Future<void> _incrementStartup() async {
    final prefs = await SharedPreferences.getInstance();

    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);

    if (currentStartupNumber == 3) {
      setState(() => _haveStarted3Times = '$currentStartupNumber Times Completed');

      // Reset only if you want to
      await _resetCounter();
    } else {
      setState(() => _haveStarted3Times = '$currentStartupNumber Times started the app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _haveStarted3Times,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }*/
  bool _tryAgain=true;
  TextEditingController pass = TextEditingController();
  SharedPreferences sh;

  @override
  void initState() {
    super.initState();
    _checkWifi();
  }

  Future <void> _checkWifi() async {
    final sh = await SharedPreferences.getInstance();
    String flag=await _getBoolformshared();

    await sh.setString('counter', flag);

    if(flag==""){
      Future.delayed(Duration.zero,()=> _showAlert(context));
    }


    //sh.setBool("counter", _tryAgain);

  }
  Future<String> _getBoolformshared()async {
    final sh=await SharedPreferences.getInstance();
    final str=sh.getString("counter");
    if(str==null){
      return "";
    }
    return str;



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
            onPressed: ()async {
              final sh=await SharedPreferences.getInstance();
              await sh.setString('counter', '1213134');
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
