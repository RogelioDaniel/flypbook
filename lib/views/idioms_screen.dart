import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flypbook/components/vertical_menu.dart';
import 'package:http/http.dart' as http;

import '../components/menu_drawer.dart';
import 'favorite_item.dart';

class IdiomsScreen extends StatelessWidget {
  final List<Widget> favoriteItems = [
    FavoriteItem(
      image: 'lib/assets/logo.png',
      title: 'Idiom 1',
      description: 'Description for Idiom 1',
    ),
    FavoriteItem(
      image: 'https://via.placeholder.com/200x200',
      title: 'Idiom 2',
      description: 'Description for Idiom 2',
    ),
    FavoriteItem(
      image: 'https://via.placeholder.com/200x200',
      title: 'Idiom 3',
      description: 'Description for Idiom 3',
    ),
  ];

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
