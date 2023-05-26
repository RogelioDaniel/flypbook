import 'dart:convert';
import 'package:flutter/material.dart';
import '../views/menu_item_detail_screen.dart';

class VerticalMenu extends StatefulWidget {
  const VerticalMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerticalMenuState createState() => _VerticalMenuState();
}

class _VerticalMenuState extends State<VerticalMenu> {
  List<MenuItemData> _menuItems = [];
  List<MenuItemData> _filteredMenuItems = []; // Added filtered list

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus text field and dismiss keyboard
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          image: const DecorationImage(
            image: NetworkImage(
                'https://www.publicdomainpictures.net/pictures/40000/nahled/gray-background-1361959709geQ.jpg'),
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
                onTap: () {
                  // Unfocus text field and dismiss keyboard
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                primary: true,
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
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              // or 'network' from URL
              image,
              height: MediaQuery.of(context).size.width * 0.18,
              width: MediaQuery.of(context).size.width * 0.18,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.grey,
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
