import 'package:flutter/material.dart';
import 'package:flypbook/views/idioms_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idioms App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IdiomsScreen(),
    );
  }
}
