import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passwordmanager/DbHelper/dbhelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   /* DbHelper dbHelper=new DbHelper();
    List<PasswordManger> passm=List<PasswordManger>();
    dbHelper.initDatabase();
   // PasswordManger passwordManger=new PasswordManger("samienaseem", "1213134");
   // Future<int> a=dbHelper.insertEntry(passwordManger);

    //debugPrint(a.toString());
    final str=dbHelper.getPasswords();
    str.then((result){
        debugPrint(result.length.toString());
    });*/

    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Pocket Password'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper dbHelper=new DbHelper();
  List<PasswordManger> lists;
  int count=0;
  int _counter = 0;

  void _incrementCounter()async {
    SharedPreferences sh=await SharedPreferences.getInstance();
    sh.setInt('counter', _counter);

    setState(() {
      if(sh.getInt('counter')==0){
        sh.setInt('counter', _counter);
        _counter++;
      }
      else{
        int a = sh.getInt('counter');
        debugPrint(a.toString());
        _counter=a;
        _counter++;
      }


      //sh.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(lists==null){
        lists=List<PasswordManger>();
        getData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Container(
        padding: EdgeInsets.all(5.0),
        child: PasswordListitems()
      ),
      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView PasswordListitems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder:(context,position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text((position+1).toString(),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              title: Text(this.lists[position].email),
              onTap: (){
                  debugPrint("Tapped on"+position.toString());
              },
            ),
          );

        },
    );
  }

  void getData() {
    final dbfuture=dbHelper.initDatabase();
    dbfuture.then((result){
        final Passfuture=dbHelper.getPasswords();
        Passfuture.then((result){
          List<PasswordManger> pm=List<PasswordManger>();
           count=result.length;
          for(int i=0;i<count;i++){
            pm.add(PasswordManger.FromObject(result[i]));
          }
          setState(() {
            lists=pm;
            count=count;

          });
        });
    });
  }
}