import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
void main(){
runApp(new MaterialApp(
  home: Myapp(),
));

}
class Myapp extends StatefulWidget{

  @override
  State createState()=> new _state();
}

enum Answers{
  yes,
  no,
  maybe
}

class _state extends State<Myapp>{

  String _value="Hello World";
  int _val=0;
  String textFeild='';
  bool _one=false;
  bool _two=false;
  int _one1=0;//for radios
  int _two2=0;
  double val=0.0;
  String date='';
  String valueBottomnav="";
  int _index=0;
  List<BottomNavigationBarItem> _items;
  Map countries=new Map();
  String data;


  void getdata()async {
    var url ="http://country.io/names.json";
    var response=await http.get(url);

    if(response.statusCode==200){
      setState(()=>countries=json.decode(response.body));
      print("loaded ${countries.length} countries");
    }
  }

  Future getData2() async{
    print("hello");
    String url="http://theaaquibnaseem.epizy.com/post.php";
    http.Response response=await http.get(url);
    if(response.statusCode==200){
       setState(() {
         data=jsonDecode(response.body);
       });


    }

  }




  @override
  void initState() {
  _items=new List();
  _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.home),title: new Text("Home")));
  _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.info),title: new Text("About")));
  _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.people),title: new Text("Contact")));
 // getdata();
  getData2();
  


  }

  void _onPressed(String value){

    setState(() {
      _value=value;
    });


  }
  void _onpressed2(){
    setState(() {
      //_value= new DateTime.now().toString();
      _val++;
    });
  }
  void _add(){
    setState(() {
      _val++;
    });
  }
  void _sub(){
    setState(() {
      _val--;
    });
  }

  void _onchange(String value){
    setState(() {
      textFeild='change: ${value}';
      value=value;
    });
  }
  void _onsubmit(String value){
    setState(()=> textFeild='submit: ${value}');
  }
  void onecheckbox(bool value)=> setState(()=>_one=value);//also used it for switches
  void twocheckbox(bool value)=> setState(()=>_two=value);

  void _oneradios(int value)=>setState(()=>_one1=value);
  void _tworadios(int value)=>setState(()=>_two2=value);

  Widget makeRadios(){
     List<Widget> list=new List();
    for(int i=0; i<3; i++){
      list.add(new Radio(value: i, groupValue: _one1, onChanged: _oneradios));
    }
    Column column=new Column(children: list,);
    return column;
  }

  Widget makeRadiosTiles(){
    List<Widget> list=new List();
    for(int i=0; i<3; i++){
      list.add(new RadioListTile(
          value: i,
          groupValue: _two2,
          onChanged: _tworadios,
          activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.trailing,
          title: new Text("Hello this is checkbox"),
          subtitle: new Text("Subtitles"),
          secondary: new Icon(Icons.access_alarm),

      ));
    }
    Column column=new Column(children: list,);
    return column;
  }

  void setStateofSlider(double value)=>setState(()=> val=value);

  Future setDate()async{
    DateTime picked=await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2022),
    );
    if(picked!=null) setState(()=> date=picked.toString());
  }
  
  void showBottom(){
    showModalBottomSheet<void>(
      context:context,
      builder: (BuildContext context){
        return new Container(
          padding: EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Some info here",style: new TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.red,),),
              new RaisedButton(onPressed: ()=>Navigator.pop(context),child: new Text("closed"),)
            ],
          ),
        );
      }

    );
  }
  final GlobalKey<ScaffoldState> _scaffoldstate=new GlobalKey();

  void showSnackbar(){
    _scaffoldstate.currentState.showSnackBar(new SnackBar(content: new Text("Snack bar called")));
  }
  void showSnackbar1(String msg){
    _scaffoldstate.currentState.showSnackBar(new SnackBar(content: new Text(msg+"")));
  }

  Future showAlertDialog(BuildContext context,String message){
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          content: new Text("hello"),
          actions: <Widget>[
            new FlatButton(onPressed: ()=>Navigator.pop(context), child: new Text("ok"))
          ],
        )
    );
  }
  Future showAlertDialogWithOptions()async{
    switch(
    await showDialog(
    context: context,
    child: new SimpleDialog(
    title: new Text("Do you like flutter"),
    children: <Widget>[
    new SimpleDialogOption(onPressed:()=>Navigator.pop(context,Answers.yes),child: new Text("Yes!!!"),),
    new SimpleDialogOption(onPressed:()=>Navigator.pop(context,Answers.no),child: new Text("No"),),
    new SimpleDialogOption(onPressed:()=>Navigator.pop(context,Answers.maybe),child: new Text("Maybe"),)
    ],
    )
    )
    ){
      case Answers.yes: _onPressed("yes");
      break;
      case Answers.no: _onPressed("no");
      break;
      case Answers.maybe: _onPressed("maybe");
      break;



    }
  }
  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();











  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      key: _scaffoldstate,
      appBar: new AppBar(
        title: new Text("Demo application"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _add),
          new IconButton(icon: new Icon(Icons.remove), onPressed: _sub)
        ],
      ),
      /*persistentFooterButtons: <Widget>[
        new IconButton(icon: new Icon(Icons.people), onPressed: ()=>_onPressed("Button 1")),
        new IconButton(icon: new Icon(Icons.access_alarm), onPressed: ()=>_onPressed("Button 2")),
        new IconButton(icon: new Icon(Icons.accessible_forward), onPressed: ()=>_onPressed("Button 3")),
        new IconButton(icon: new Icon(Icons.accessibility), onPressed: ()=>_onPressed("Button 4")),
      ],*/
      drawer: new Drawer(
        child: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Text("Hello this is drawer"),
              new RaisedButton(onPressed: ()=>Navigator.pop(context),child: new Text("close"),)
            ],
          ),
        ),
      ),

      floatingActionButton: new FloatingActionButton(
          onPressed: _onpressed2,
          backgroundColor: Colors.green,
          mini: false,
          child: new Icon(Icons.add),
      ),


      //********************************************************************************8
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            children: <Widget>[

              new Text("list of countries",style: new TextStyle(fontWeight: FontWeight.bold),),
              new Expanded(
                  child: new ListView.builder(
                      itemBuilder:(BuildContext context, int index){
                        String key=countries.keys.elementAt(index);
                        return new Row(
                          children: <Widget>[
                            new Text('${ key } :' ),
                            new Text(countries[key]),

                          ],
                        );
                      },
                      itemCount: countries.length,
                  )
              ),
              new Text(data.toString()),
              /*new Row(
                children: <Widget>[
                  new Text("Username:  "),
                  new Expanded(child: new TextField(controller: user,))
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text("Password:  "),
                  new Expanded(child: new TextField(controller: pass,obscureText: true,))
                ],
              ),
              
              *//*new Row(
                children: <Widget>[
                  new RaisedButton(onPressed: ()=>_onPressed("Hello ${user}"),child: new Text("Login"),)
                ],
              ),*//*
              new Padding(
                padding: EdgeInsets.all(20.0),
                child:new RaisedButton(onPressed: ()=>showSnackbar1('Hello ${user}'), child: new Text("Login"),) ,
              ),
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Column(
                    children: <Widget>[
                      new Text("Hello World"),
                      new Text("This is card1")
                    ],
                  ),
                ),
              ),*/
              /*new Text('ïmage demo'),
              new Expanded(child: new Image.asset("images/arif.jpeg"),)*/

              

              
              
              /*new Text(_val.toString()),
              new Text(_value),
              new Text(_index.toString()),
              new RaisedButton(onPressed: showBottom,child: new Text("open bottom sheet"),),
              new RaisedButton(onPressed: showSnackbar,child: new Text("snack bar"),),
              new RaisedButton(onPressed: ()=>showAlertDialog(context,"Do you know samie naseem"),child: new Text("Show Alert Dialog"),),
              new RaisedButton(onPressed: showAlertDialogWithOptions, child: new Text("show simple dialog"),)*/



              /*new Text(date),
              new RaisedButton(onPressed: setDate, child: new Text("get date"),),
              new Switch(value: _one, onChanged: onecheckbox),
              new SwitchListTile(
                  value: _two,
                  onChanged: twocheckbox,
                  title: new Text("Samie Naseem",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),),
              ),
              //makeRadios(),
              //makeRadiosTiles(),
              *//*new Text(_value),
              new Text("value=${_val}"),
              new RaisedButton(onPressed: ()=>_onPressed("Saquib Naseem"),child: new Text("click me.."),),
              new RaisedButton(
                  onPressed: _onpressed2,
                  child: new Text("click me 2"),
              ),
              new IconButton(icon: new Icon(Icons.add), onPressed: _add),
              new IconButton(icon: new Icon(Icons.remove), onPressed: _sub),*//*
              new Text(textFeild),
              new TextField(
                decoration: new InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter username',
                  icon: new Icon(Icons.people)
                ),
                autocorrect: true,
                autofocus: true,
                keyboardType: TextInputType.text,
                onChanged: _onchange,
                onSubmitted: _onsubmit,
              ),
              new Checkbox(value: _one, onChanged:onecheckbox),
              new CheckboxListTile(
                  value: _two,
                  onChanged: twocheckbox,
                title: new Text("Hello World"),
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: new Text("Subtitle"),
                secondary: new Icon(Icons.accessible_forward),
                activeColor: Colors.red,
              ),
              new Text('value: ${(val*100).round()}'),
              new Slider(value: val, onChanged: setStateofSlider),*/




            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
          items: _items,
        fixedColor: Colors.redAccent,
        currentIndex: _index,
        onTap: (int item){
            setState(() {
              _index=item;
              valueBottomnav='Current value is ${_index}';
            });
        },
        

      ),

    );
  }
}
