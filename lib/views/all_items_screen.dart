import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../components/menu_drawer.dart';
import '../components/vertical_menu.dart';
import '../components/favorite_item.dart';

class IdiomsScreen extends StatefulWidget {
  @override
  _IdiomsScreenState createState() => _IdiomsScreenState();
}

class _IdiomsScreenState extends State<IdiomsScreen> {
  List<Widget> favoriteItems = [];
  List<Widget> topics = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteItems();
    _loadTopics();
    evaluateIds();
  }

  Future<void> _loadFavoriteItems() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/data/favorite_items.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<Widget> items = [];
    for (var item in jsonData) {
      FavoriteItem favoriteItem = FavoriteItem(
        itemId: item['itemId'],
        id: item['id'],
        image: item['image'],
        title: item['title'],
        description: item['description'],
      );

      items.add(favoriteItem);
    }
    setState(() {
      favoriteItems = items;
    });
  }

  Future<void> evaluateIds() async {
    // Load favorite items
    String favoriteItemsJson =
        await rootBundle.loadString('lib/data/favorite_items.json');
    List<dynamic> favoriteItemsData = json.decode(favoriteItemsJson);
    List<String> favoriteItemIds = [];
    for (var itemData in favoriteItemsData) {
      favoriteItemIds.add(itemData['id']);
    }

    // Load topics
    String topicsJson = await rootBundle.loadString('lib/data/topics.json');
    List<dynamic> topicsData = json.decode(topicsJson);

    // Find topics with common IDs
    List<dynamic> commonTopics = topicsData.where((topicData) {
      String topicId = topicData['id'];
      return favoriteItemIds.contains(topicId);
    }).toList();

    // Print the output
    print('Common Topics:');
    for (var topic in commonTopics) {
      print('ID: ${topic['id']}');
      print('Title: ${topic['title']}');
      print('Description: ${topic['description']}');
      print('---');
    }
  }

  Future<void> _loadTopics() async {
    String jsonString = await rootBundle.loadString('lib/data/topics.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<Widget> items = [];
    for (var item in jsonData) {
      // Assuming the structure of each topic is similar to FavoriteItem
      FavoriteItem topicItem = FavoriteItem(
        itemId: item['itemId'],
        id: item['id'],
        image: item['image'],
        title: item['title'],
        description: item['description'],
      );

      items.add(topicItem);
    }
    setState(() {
      topics = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = const Color.fromARGB(255, 3, 3, 3),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            CarouselSlider(
              items: favoriteItems,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width * 0.5,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            SizedBox(height: 32.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Vertical Menu',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: VerticalMenu(),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
