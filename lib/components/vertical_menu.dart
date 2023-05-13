import 'dart:convert';
import 'package:flutter/material.dart';
import '../views/item_detail_screen.dart';
import '../views/menu_item_detail_screen.dart';

class VerticalMenu extends StatefulWidget {
  @override
  _VerticalMenuState createState() => _VerticalMenuState();
}

class _VerticalMenuState extends State<VerticalMenu> {
  List<MenuItemData> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/components/menu_items.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<MenuItemData> menuItems = [];
    for (var item in jsonData) {
      MenuItemData menuItem = MenuItemData(
        image: item['image'],
        title: item['title'],
        description: item['description'],
      );
      menuItems.add(menuItem);
    }
    setState(() {
      _menuItems = menuItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        // Added SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Vertical Menu',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                MenuItemData menuItem = _menuItems[index];
                return GestureDetector(
                  onTap: () {
                    navigateToMenuItemDetail(
                      context,
                      menuItem.title,
                      menuItem.description,
                      menuItem.image,
                    );
                  },
                  child: MenuItem(
                    image: menuItem.image,
                    title: menuItem.title,
                    description: menuItem.description,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const MenuItem({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Image.network(
            image,
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final String image;
  final String title;
  final String description;

  MenuItemData({
    required this.image,
    required this.title,
    required this.description,
  });
}

void navigateToMenuItemDetail(
    BuildContext context, String title, String description, String image) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MenuItemDetailScreen(
        title: title,
        description: description,
        image: image,
      ),
    ),
  );
}
