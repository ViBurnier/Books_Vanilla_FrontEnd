import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String parseDate(String birth){
  DateFormat inputFormat = DateFormat("dd/MM/yyyy");
  DateFormat outputFormat = DateFormat("yyyy-MM-dd");

  DateTime dateParse = inputFormat.parse(birth);
  String dateFinal = outputFormat.format(dateParse);
  return dateFinal;
}

class _MyAppState extends State<Register>{
  String _username = '';
  String _email = '';
  String _password = '';
  String _cpf = '';
  String _tel = '';
  String _address = '';
  String _birth = '';

  bool _isLoggedIn = false;

  void setUsername(String username) {
    setState(() {
      _username = username;
    });
  }

  void setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  void setEmail(String email){
    setState((){
      _email = email;
    });
  }

 void setCpf(String cpf){
    setState(() {
      _cpf = cpf;
    });
 }

 void setTel(String tel){
    setState(() {
      _tel = tel;
    });
 }

 void setAddress(String address){
    setState(() {
      _address = address;
    });
 }

 void setBirth(String birth){
    setState(() {
      _birth = parseDate(birth);
    });
 }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _MyAppState();

}

Future<void> register() async{
  await Future.delayed(const Duration(seconds: 1));
  final url = Uri.parse('http://10.144.31.8:8080/api/account/create');

  final body = json.decoder({
    'name': _username,
    'email': _email,
    'password': _password,
    'cpf': _cpf,
    'tel': _tel,
    'address': _address,
    'birth': _birth,
  });

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Set the content type to JSON
      'Accept': 'application/json',
    },
    body: body
  );

  setState((){

  })
}
