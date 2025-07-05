import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dio_register-book.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  String _userEmail = '';
  String _password = '';
  bool _isLoggedIn = false;
  String _errorMessage = '';
  dynamic _responseBody;

  void setUserEmail(String userEmail) {
    setState(() {
      _userEmail = userEmail;
    });
  }

  void setPassword(String password) {
    setState(() {
      _password = password;
    });
  }

  Future<void> login() async {
    await Future.delayed(const Duration(seconds: 1));
    final url = Uri.parse('http://192.168.1.3:8080/api/account/login');

    // Create the request body
    final body = json.encode({'email': _userEmail, 'password': _password});


    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
        'Accept': 'application/json',
      },
      body: body,
    );

    setState(() {
      if (response.statusCode == 200) {
        _isLoggedIn = true;
        _errorMessage = '';
         print('Login successful: ${response.body}');
         final responseBody = json.decode(response.body);

         //========retorna um valor especifico do body=========
        // String userName = responseBody['data']['name'];
        // print('Name: $userName');

      } else {
        _isLoggedIn = false;
        _errorMessage = 'Invalid username or password';

      }
    });
  }

  void logout() {
    setState(() {
      _isLoggedIn = false;
      _userEmail = '';
      _password = '';
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _isLoggedIn
          ? HomePage(userEmail: _userEmail)
          : LoginPage(
              setUserEmail: setUserEmail,
              setPassword: setPassword,
              login: login,
              errorMessage: _errorMessage,
            ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final Function(String) setUserEmail;
  final Function(String) setPassword;
  final Function() login;
  final String errorMessage;

  const LoginPage({
    super.key,
    required this.setUserEmail,
    required this.setPassword,
    required this.login,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          iconSize: 30.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // deslocamento da sombra
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Center( child: Text('Login', style: TextStyle(color: Colors.white))),
                    decoration: BoxDecoration(color: Colors.black),
                  ),*/
                  const SizedBox(height: 26.0),

                  TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      fillColor: Colors.white12,
                      filled: true,
                      labelText: 'EMAIL',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setUserEmail(value),
                  ),

                  const SizedBox(height: 26.0),

                  TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      fillColor: Colors.white12,
                      filled: true,
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: (value) => setPassword(value),
                  ),

                  const SizedBox(height: 50.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black, // Cor do texto/ícone
                    ),
                    onPressed: () => login(),
                    child: const Text('Login'),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  const SizedBox(height: 50.0),

                  InkWell(
                    child: Text(
                      'Esqueci a senha',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    onTap: () => {Navigator.pushNamed(context, '')},
                  ),

                  const SizedBox(height: 20.0),

                  Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'Sing Up',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),

                  /*InkWell(
                    child: Text(
                      'Sing Up',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    onTap: () => {Navigator.pushNamed(context, '/register')},
                  ),*/
                  const SizedBox(height: 10.0),

                  /*        IconButton(
                    color: Colors.black,
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                      }, icon: Icon(Icons.arrow_back))*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userEmail;

  const HomePage({super.key, required this.userEmail});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem Vindo, $userEmail!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterBook()),
              ),
              child: const Text('register book'),
            ),
          ],
        ),
      ),
    );
  }
}
