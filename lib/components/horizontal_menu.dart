import 'package:flutter/material.dart';
import 'package:flypbook/models/horizontal_menu_item.dart';

class HorizontalMenu extends StatelessWidget {
  final List<HorizontalMenuItem> items = [
    HorizontalMenuItem(
      title: 'Item 1',
      description: 'Description 1',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    HorizontalMenuItem(
      title: 'Item 2',
      description: 'Description 2',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    HorizontalMenuItem(
      title: 'Item 3',
      description: 'Description 3',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

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
