import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  final String text;

  const BookPage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
