import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _MyAppState();

}

class _MyAppState extends State<Register>{
  String _username = '';
  String _email = '';
  String _password = '';
  String _cpf = '';
  String _tel = '';
  String _address = '';
  String birth = '';

  bool _isLoggedIn = false;
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

    //eu preciso que o user possa, digitar a data em formato dd/mm/yyyy
    //o banco espera format ISO yyyy-mm-dd
    //tenho que, em algum momento, converter para ISO ->
    //1-> em qual momento faco isso
    //2-> posso criar uma function para isso? (acho que sim)

    //ideia: DateFormatField, e no build receber a date
  })

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Set the content type to JSON
      'Accept': 'application/json',
    },
    body: body
  )
}
