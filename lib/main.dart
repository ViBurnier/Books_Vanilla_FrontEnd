import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teste/utils/my_drawer.dart';
import 'utils/my_appBar.dart';
import 'utils/my_footer.dart';
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
      appBar: MyAppBar(titulo: "Books Vanilla",),

      body: FutureBuilder<List<Map<String, String>>>(

        future: fetchAndReturnBookList(apiUrl, properties),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is loading, you can show a loading indicator.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display error message if something went wrong.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // No data case.
            return Center(child: Text('No books found.'));
          } else {
            // We have our list of books. Now build the grid.
            final books = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: books.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  var book = books[index];
                  return BookCard(
                    // Adjust property keys to your API response keys.
                    title: book['title'] ?? 'No Title',
                    author: book['author'] ?? 'No Author',
                    imageUrl: book['coverImageUrl'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhjUyQ760_j4k4sEKfv_7ALMg84oQUpR3eg&',
                    synopsis: book['price'] ?? 'No Synopsis',
                  );
                },
              ),
            );
          }
        },
      ),

      backgroundColor: Colors.white,
      bottomNavigationBar: MyFooter(),
      drawer: MyDrawer(),

    );
  }
}


class BurguerMenu extends StatelessWidget {
  const BurguerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerButton();
  }
}


class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final String synopsis;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Handle image loading errors gracefully
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.error, color: Colors.redAccent),
                    ),
                  );
                },
              ),
            ),
          ),
          // Book Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              author,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              synopsis,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

