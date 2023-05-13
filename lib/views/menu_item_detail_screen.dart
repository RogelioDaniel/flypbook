import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flypbook/views/topic_screen.dart';

class MenuItemDetailScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const MenuItemDetailScreen({
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Image.asset(
              image,
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),
            TopicScreen(), // Show the TopicScreen component
          ],
        ),
      ),
    );
  }
}
