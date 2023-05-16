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
  List<MenuItemData> _filteredMenuItems = []; // Added filtered list
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
    _searchQuery = '';
  }

  Future<void> _loadMenuItems() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('lib/data/all_items.json');
    List<dynamic> jsonData = json.decode(jsonString);
    List<MenuItemData> menuItems = [];
    for (var item in jsonData) {
      MenuItemData menuItem = MenuItemData(
        itemId: item['itemId'],
        image: item['image'],
        title: item['title'],
        description: item['description'],
      );
      menuItems
          .sort((a, b) => a.title.compareTo(b.title)); // Sort alphabeticaly
      menuItems.add(menuItem);
    }
    setState(() {
      _menuItems = menuItems;
      _filteredMenuItems =
          menuItems; // Initialize filtered list with all menu items
    });
  }

  void _filterMenuItems(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty) {
        _filteredMenuItems = _menuItems.where((menuItem) {
          return menuItem.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        _filteredMenuItems =
            _menuItems; // Show all menu items if query is empty
      }
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.white, Colors.black26],
          ),
          image: const DecorationImage(
            image: NetworkImage(
                'https://images.pexels.com/photos/5202288/pexels-photo-5202288.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) => _filterMenuItems(value),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredMenuItems.length,
                itemBuilder: (context, index) {
                  MenuItemData menuItem = _filteredMenuItems[index];
                  return GestureDetector(
                    onTap: () {
                      // Unfocus text field and dismiss keyboard
                      FocusScope.of(context).unfocus();

                      navigateToMenuItemDetail(
                        context,
                        menuItem.itemId,
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
          Image.asset(
            // or can 'network' from url
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
  final String itemId;
  final String image;
  final String title;
  final String description;

  MenuItemData({
    required this.itemId,
    required this.image,
    required this.title,
    required this.description,
  });
}

void navigateToMenuItemDetail(BuildContext context, String itemId, String title,
    String description, String image) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MenuItemDetailScreen(
        itemId: itemId,
        title: title,
        description: description,
        image: image,
      ),
    ),
  );
}
