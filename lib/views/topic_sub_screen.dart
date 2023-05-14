import 'package:flutter/material.dart';
import 'package:flypbook/models/topic_item.dart';

class TopicSubScreen extends StatelessWidget {
  final TopicItem topicItem;

  TopicSubScreen({required this.topicItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topicItem.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                topicItem.image,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              topicItem.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              topicItem.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: topicItem.items.length,
                itemBuilder: (context, index) {
                  final item = topicItem.items[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    onTap: () {
                      // Navigate to subtopic screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
