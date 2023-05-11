import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flypbook/apod_home_controller.dart';

import 'image_carousel.dart';

class APODHomePage extends StatefulWidget {
  @override
  _APODHomePageState createState() => _APODHomePageState();
}

class _APODHomePageState extends State<APODHomePage> {
  late APODHomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = APODHomeController(updateStateCallback: () {
      setState(() {});
    });
    _controller.fetchAPOD(_controller.selectedDate);
    _controller.fetchAPOD(_controller.selectedDate.subtract(Duration(days: 1)));
    _controller.fetchAPOD(_controller.selectedDate.subtract(Duration(days: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APOD NASA'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              DateFormat('MMMM d, yyyy').format(_controller.selectedDate),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ImageCarousel(
            imageUrls: _controller.apodImageUrls,
            onPageChanged: (index, _) {
              _controller.setSelectedDate(index);
            },
          ),
          SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    _controller.apodDescription,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.apodImageUrls.isNotEmpty) {
                        _controller.setWallpaper(_controller.apodImageUrls[0]);
                      }
                    },
                    child: Text('Set as Wallpaper'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('Select Date'),
          ),
        ],
      ),
    );
  }
}
