import 'package:flutter/material.dart';

void main() {
  runApp(BooksVanilla());
}

class BooksVanilla extends StatelessWidget {
  const BooksVanilla({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books Vanilla',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final List<Map<String, String>> books = [
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'image':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhjUyQ760_j4k4sEKfv_7ALMg84oQUpR3eg&s'
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'image':
      'https://miro.medium.com/v2/resize:fit:800/1*g8s4n-puPV3y-F2b7ilJ_A.jpeg'
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/1200px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg'
    },
    {
      'title': 'Moby-Dick',
      'author': 'Herman Melville',
      'image':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm5hiiHoNxojxLBxy2m1qAFf-zGZsYUzO0KQ&s'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books Vanilla'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Featured Book Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(139, 218, 123, 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Livro do Dia",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Descubra o Melhor da Literatura!",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            // Books Grid Section
            Padding(
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
                  final book = books[index];
                  return BookCard(
                    title: book['title']!,
                    author: book['author']!,
                    imageUrl: book['image']!,
                  );
                },
              ),
            ),
            BurguerMenu(),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
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


class Footer extends StatelessWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Color.fromRGBO(41, 41, 41, 1.0),
        child: Text("Copy Books Vanilla 2025", style: TextStyle(color: Color.fromRGBO(
            255, 255, 255, 1.0))),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
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
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
