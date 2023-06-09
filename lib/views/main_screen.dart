import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:circles_background/circles_background.dart';
import '../components/menu_drawer.dart';
import '../components/vertical_menu.dart';
import '../components/favorite_item.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  _AllItemsScreenState createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  List<Widget> allItems = [];

  bool animate = true; // Placeholder value for animate variable

  @override
  void initState() {
    super.initState();

    _loadAllItems();
  }

  @override
  void dispose() {
    super.dispose();
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
    return GestureDetector(
        // Add GestureDetector to handle tap anywhere on the screen
        onTap: () {
          // Unfocus text field and dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Principal'),
          ),
          drawer: MenuDrawer(),
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
                    Color.fromARGB(255, 82, 82, 82),
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
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(
                      horizontal: animate ? 16.0 : 0.0,
                    ),
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
        ));
  }
}
