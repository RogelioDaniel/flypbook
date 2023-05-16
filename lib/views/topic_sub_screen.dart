import 'package:flutter/material.dart';
import 'package:flypbook/models/topic_item.dart';
import 'package:circles_background/circles_background.dart';

class TopicSubScreen extends StatelessWidget {
  final TopicItem topicItem;

  TopicSubScreen({required this.topicItem});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text(topicItem.title),
          ),
          extendBodyBehindAppBar: false,
          body: CirclesBackground(
            circles: [
              CircleInfo(
                size: const Size(300, 500),
                color: Color.fromARGB(255, 139, 139, 139),
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(200)),
                alignment: Alignment.topRight,
              ),
              CircleInfo(
                size: const Size(300, 900),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 138, 138, 138),
                    Color.fromARGB(255, 97, 97, 97),
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
                    Color.fromARGB(255, 138, 138, 138),
                    Color.fromARGB(255, 97, 97, 97),
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
                      height: constraints.maxHeight * 0.25,
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
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    topicItem.description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: topicItem.items.length,
                      itemBuilder: (context, index) {
                        final item = topicItem.items[index];
                        return Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define how the card's content should be clipped
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  color: Color.fromARGB(255, 239, 238, 238),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    title: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item.description,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigate to subtopic screen
                                    },
                                  ),
                                )));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
