import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:  TextStyle(fontSize: 20),
      decoration:  InputDecoration(
        fillColor: Colors.white12,
        filled: true,
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
      //onChanged: (value) => setUsername(value),
    );
  }
}