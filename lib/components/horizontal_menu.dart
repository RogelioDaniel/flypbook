import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flypbook/models/horizontal_menu_item.dart';

class HorizontalMenu extends StatefulWidget {
  @override
  _HorizontalMenuState createState() => _HorizontalMenuState();
}

class _HorizontalMenuState extends State<HorizontalMenu> {
  List<HorizontalMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/data/menu_items.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<HorizontalMenuItem> menuItems = [];
    for (var item in jsonData) {
      HorizontalMenuItem menuItem = HorizontalMenuItem(
        title: item['title'],
        description: item['description'],
        imageUrl: item['imageUrl'],
      );
      menuItems.add(menuItem);
    }
    setState(() {
      items = menuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 120.0,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Image.network(
                  items[index].imageUrl,
                  width: 80.0,
                  height: 80.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  items[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(items[index].description),
              ],
            ),
          );
        },
      ),
    );
  }
}
