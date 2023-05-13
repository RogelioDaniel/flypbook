import 'package:flutter/material.dart';
import 'package:flypbook/views/topic_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ItemDetailScreen({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),
            TopicScreen(), // Show the TopicScreen component with the provided topicItems
          ],
        ),
      ),
    );
  }
}
