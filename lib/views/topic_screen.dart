import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  final List<TopicItem> topicItems = [
    TopicItem(
      image: 'assets/images/topic1.png',
      title: 'Topic 1',
      description: 'Description for Topic 1',
    ),
    TopicItem(
      image: 'assets/images/topic2.png',
      title: 'Topic 2',
      description: 'Description for Topic 2',
    ),
    TopicItem(
      image: 'assets/images/topic3.png',
      title: 'Topic 3',
      description: 'Description for Topic 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Topics',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 180.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topicItems.length,
            itemBuilder: (context, index) {
              final item = topicItems[index];
              return Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TopicItemCard(
                  image: item.image,
                  title: item.title,
                  description: item.description,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicSubScreen(topicItem: item),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopicItem {
  final String image;
  final String title;
  final String description;

  TopicItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class TopicItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const TopicItemCard({
    required this.image,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                image,
                height: 100.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Subtopic ${index + 1}'),
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
