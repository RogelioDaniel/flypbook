import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'class1_screen.dart';
import 'class2_screen.dart';
import 'class3_screen.dart';
import 'menu_item.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Item 1',
      description: 'This is the description for item 1.',
      imageUrl: 'https://example.com/image1.jpg',
    ),
    MenuItem(
      title: 'Item 2',
      description: 'This is the description for item 2.',
      imageUrl: 'https://example.com/image2.jpg',
    ),
    MenuItem(
      title: 'Item 3',
      description: 'This is the description for item 3.',
      imageUrl: 'https://example.com/image3.jpg',
    ),
  ];

  int _selectedMenuItemIndex = 0;

  Widget _buildMenuItem(int index) {
    final menuItem = menuItems[index];
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: menuItem.imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Text(
        menuItem.title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        menuItem.description,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      onTap: () {
        setState(() {
          _selectedMenuItemIndex = index;
        });
        Navigator.pop(context);
      },
      selected: index == _selectedMenuItemIndex,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  List<Widget> _buildMenuItems() {
    return List.generate(menuItems.length, (index) => _buildMenuItem(index));
  }

  Widget _buildSideMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ..._buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedMenuItemIndex) {
      case 0:
        return Class1Screen();
      case 1:
        return Class2Screen();
      case 2:
        return Class3Screen();
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: _buildSideMenu(),
      body: _buildBody(),
    );
  }
}
