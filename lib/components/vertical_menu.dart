import 'package:flutter/material.dart';
import '../views/item_detail_screen.dart';
import '../views/menu_item_detail_screen.dart';

class VerticalMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
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
          GestureDetector(
            onTap: () {
              navigateToMenuItemDetail(
                context,
                'Random Item',
                'Description for Random Item',
                'https://via.placeholder.com/200x200',
              );
            },
            child: MenuItem(
              image: 'https://via.placeholder.com/200x200',
              title: 'Random Item',
              description: 'Description for Random Item',
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateToMenuItemDetail(
                context,
                'Item 1',
                'Description for Item 1',
                'assets/logo.png',
              );
            },
            child: MenuItem(
              image: 'https://via.placeholder.com/200x200',
              title: 'Item 1',
              description: 'Description for Item 1',
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateToMenuItemDetail(
                context,
                'Item 2',
                'Description for Item 2',
                'https://via.placeholder.com/200x200',
              );
            },
            child: MenuItem(
              image: 'https://via.placeholder.com/200x200',
              title: 'Item 2',
              description: 'Description for Item 2',
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateToMenuItemDetail(
                context,
                'Item 3',
                'Description for Item 3',
                'https://via.placeholder.com/200x200',
              );
            },
            child: MenuItem(
              image: 'https://via.placeholder.com/200x200',
              title: 'Item 3',
              description: 'Description for Item 3',
            ),
          ),
          // Add more menu items as needed
        ],
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
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
