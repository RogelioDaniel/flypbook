import 'package:flutter/material.dart';
import 'package:flypbook/views/topic_screen.dart';
import '../views/item_detail_screen.dart' as ItemDetailScreen;

class FavoriteItem extends StatelessWidget {
  final String itemId;
  final String id;
  final String image;
  final String title;
  final String description;

  const FavoriteItem({
    required this.itemId,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  void idknow() {
    print("sadas" + id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Material(
              child: ItemDetailScreen.ItemDetailScreen(
                itemId: itemId,
                id: id,
                image: image,
                title: title,
                description: description,
              ),
            ),
          ),
        );
        idknow();
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(height: 8.0),
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
