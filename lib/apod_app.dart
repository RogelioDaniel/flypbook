import 'package:flutter/material.dart';
import 'package:flypbook/apod_home_page.dart';

class APODApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APOD NASA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: APODHomePage(),
    );
  }
}
