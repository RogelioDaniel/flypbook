import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flypbook/components/topic_item_card.dart';
import 'package:flypbook/views/topic_sub_screen.dart';
import 'package:flypbook/models/topic_item.dart';

class TopicScreen extends StatefulWidget {
  final String itemId;

  const TopicScreen({
    required this.itemId,
  });

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  List<TopicItem> topicItems = [];

  @override
  void initState() {
    super.initState();
    _loadTopicItems();
  }

  Future<void> _loadTopicItems() async {
    // Load the JSON content from topics.json
    String topicsJsonString =
        await DefaultAssetBundle.of(context).loadString('lib/data/topics.json');

    // Decoding the JSON content of topics.json
    List<dynamic> topicsJsonData = json.decode(topicsJsonString);

    // Load the JSON content from favorite_items.json
    String favoritesJsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/data/all_items.json');

    // Decoding the JSON content of favorite_items.json
    List<dynamic> favoritesJsonData = json.decode(favoritesJsonString);

    // Find the favorite item with the matching itemId
    var favoriteItem = favoritesJsonData.firstWhere(
      (favorite) => favorite['itemId'] == widget.itemId,
      orElse: () => null,
    );

    if (favoriteItem != null) {
      // Filter topicsJsonData based on the favorite item's itemId
      List<dynamic> filteredTopicsJsonData = topicsJsonData.where((topic) {
        return topic['itemId'] == widget.itemId;
      }).toList();

      // Mapping the JSON data to TopicItem objects
      List<TopicItem> items = filteredTopicsJsonData.map((topic) {
        // Extract the items from the JSON data
        List<Item> subItems =
            (topic['items'] as List<dynamic>).map<Item>((item) {
          return Item(
            id: item['id'],
            title: item['title'],
            description: item['description'],
          );
        }).toList();

        return TopicItem(
          id: topic['id'],
          itemId: topic['itemId'],
          image: topic['image'],
          title: topic['title'],
          description: topic['description'],
          items: subItems,
          isFavorite: true,
        );
      }).toList();

      setState(() {
        topicItems = items;
      });
    }
  }

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
              color: Colors.black,
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
                  id: item.id,
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
