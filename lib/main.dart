import 'dart:convert';

import 'package:flutter/material.dart';
import 'utils/my_appBar.dart';
import 'utils/my_drawer.dart';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchBookList(String apiUrl) async {

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load data, status code: ${response.statusCode}');
    }

    // Decode the JSON response.
    final jsonResponse = json.decode(response.body);

    if (jsonResponse is! Map<String, dynamic> ||
        jsonResponse['data'] is! List<dynamic>) {
      throw Exception('Unexpected JSON structure: "data" list not found.');
    }

    return jsonResponse['data'];
  }

  catch (error) {
    throw Exception('Error fetching data: $error');
  }
}

/// Fetches the JSON list of books from [apiUrl] and returns each book's
/// specified properties as a List of Map<String, String>.
Future<List<Map<String, String>>> fetchAndReturnBookList(
    String apiUrl, List<String> properties) async {
  // Prepare an empty list to store the books.
  List<Map<String, String>> bookList = [];

  try {
    // Assume fetchBookList is defined elsewhere and returns List<dynamic>.
    List<dynamic> books = await fetchBookList(apiUrl);

    // Process each book.
    for (var book in books) {
        // Create a new map to store the values for the desired properties.
        Map<String, String> bookData = {};

        for (var property in properties) {
          // Retrieve each property value, convert it to a string, or default to an empty string.
          bookData[property] = book[property]?.toString() ?? '';
        }

        // Add this map to the list.
        bookList.add(bookData);
    }
  }

  catch (error) {
    print('Error: $error');
  }

  return bookList;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books Vanilla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const Home(),

      },
    );
  }
}



  final String apiUrl = "http://192.168.1.3:8080/api/book/list";
  final List<String> properties = ['title', 'price', 'genre','coverImageUrl','author'];

class Home extends StatelessWidget {
  const Home({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titulo: "DecoDe",),
      drawer: MyDrawer(),

      body: const Text("MAIN BODY",),

      backgroundColor: Colors.white,
    );
  }
}

