import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home: RateFuel(),
  ));
}

class RateFuel extends StatefulWidget {
  @override
  Fuelcoststate createState() => new Fuelcoststate();
}

class Fuelcoststate extends State<RateFuel> {
  String _value;
  final _currencies = ['Doller', 'Rupees', 'Euro'];
  String _current = "Doller";

  void onChangedDropDown(String value) {
    setState(() {
      this._current = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo @2"),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: "Write",
                    hintText: 'username',
                    icon: Icon(Icons.people)),
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              DropdownButton<String>(
                items: _currencies.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _current,
                onChanged: (String value) {
                  onChangedDropDown(value);
                },
              ),
              Text("Hello : " + _value)
            ],
          ),
        ),
      ),
    );
  }
}
