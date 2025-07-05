import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class PageBook extends StatelessWidget{

  const PageBook({super.key});

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    String? label;
    String? author;
    String? imageUrl;
    String? synopsis;

    if (args != null) {
      label = args['title'];
      author = args['author'];
      imageUrl = args['imageUrl'];
      synopsis = args['synopsis'];
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: SizedBox(
            width: 350,
            height: 350,
            child: Image.network("https://i.imgur.com/h7f6grg.png"),
          ),toolbarHeight: 150,
        ),

        body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
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
                  label!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  author!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  synopsis!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),

    );
  }


}