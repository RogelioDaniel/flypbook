import 'package:flutter/material.dart';
import 'package:flypbook/views/topic_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  final String id;
  final String image;
  final String title;
  final String description;

  const ItemDetailScreen({
    required this.itemId,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image or color
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glass-like overlay
          Container(
            color: const Color.fromARGB(255, 229, 210, 210)
                .withOpacity(0.3), // Adjust the opacity as desired
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 210, 210)
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.8), // Adjust the shadow color and opacity as desired
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: const Color.fromARGB(255, 23, 23,
                          23), // Adjust the border color as desired
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors
                                .black87, // Adjust the text color as desired
                            letterSpacing: 0.8,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                SizedBox(height: 16.0),
                Divider(
                  height: 1.0,
                  color: Colors.grey[300],
                  thickness: 1.0,
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: TopicScreen(itemId: itemId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
