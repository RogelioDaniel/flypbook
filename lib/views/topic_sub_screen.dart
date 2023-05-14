import 'package:flutter/material.dart';
import 'package:flypbook/models/topic_item.dart';
import 'package:circles_background/circles_background.dart';

class TopicSubScreen extends StatelessWidget {
  final TopicItem topicItem;

  TopicSubScreen({required this.topicItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topicItem.title),
      ),
      body: CirclesBackground(
        circles: [
          CircleInfo(
            size: const Size(300, 500),
            color: Color.fromARGB(255, 233, 192, 68),
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(200)),
            alignment: Alignment.topRight,
          ),
          CircleInfo(
            size: const Size(300, 900),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 179, 160, 24)!,
                Color.fromARGB(255, 211, 125, 28),
              ],
            ),
            borderRadius: const BorderRadius.only(),
            alignment: Alignment.topLeft,
          ),
          CircleInfo(
            size: const Size(200, 500),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 179, 160, 24)!,
                Color.fromARGB(255, 242, 131, 4),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(150),
            ),
            alignment: Alignment.bottomRight,
          ),
        ],
        child: Padding(
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
      ),
    );
  }
}
