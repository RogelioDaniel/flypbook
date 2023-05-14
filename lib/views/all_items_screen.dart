import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:circles_background/circles_background.dart';

import '../components/menu_drawer.dart';
import '../components/vertical_menu.dart';
import '../components/favorite_item.dart';

class AllItemsScreen extends StatefulWidget {
  @override
  _AllItemsScreenState createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  List<Widget> allItems = [];

  @override
  void initState() {
    super.initState();
    _loadAllItems();
  }

  Future<void> _loadAllItems() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/data/favorite_items.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<Widget> items = [];
    for (var item in jsonData) {
      FavoriteItem favorite_item = FavoriteItem(
        itemId: item['itemId'],
        id: item['id'],
        image: item['image'],
        title: item['title'],
        description: item['description'],
      );

      items.add(favorite_item);
    }
    setState(() {
      allItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      drawer: MenuDrawer(),
      body: CirclesBackground(
        circles: [
          CircleInfo(
              size: const Size(300, 500),
              color: Color.fromARGB(255, 233, 192, 68),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(200)),
              alignment: Alignment.topRight),
          CircleInfo(
              size: const Size(300, 900),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 179, 160, 24)!,
                    Color.fromARGB(255, 211, 125, 28)
                  ]),
              borderRadius: const BorderRadius.only(),
              alignment: Alignment.topLeft),
          CircleInfo(
              size: const Size(200, 500),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 179, 160, 24)!,
                    Color.fromARGB(255, 242, 131, 4)
                  ]),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(150)),
              alignment: Alignment.bottomRight),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              CarouselSlider(
                items: allItems,
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
                  'Principal Menu',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
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
      ),
    );
  }
}
