import 'package:flutter/material.dart';

import '../views/item_detail_screen.dart' as item_detail_screen;

class FavoriteItem extends StatelessWidget {
  final String itemId;
  final String id;
  final String image;
  final String title;
  final String description;

  const FavoriteItem({
    super.key,
    required this.itemId,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus text field and dismiss keyboard
        FocusScope.of(context).unfocus();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Material(
              child: item_detail_screen.ItemDetailScreen(
                itemId: itemId,
                id: id,
                image: image,
                title: title,
                description: description,
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 153, 153, 153),
              Color.fromARGB(255, 196, 195, 195),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                image,
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4.0),
            Text(
              description,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black54,
              ),
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
