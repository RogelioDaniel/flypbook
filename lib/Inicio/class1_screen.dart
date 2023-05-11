import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Class1Screen extends StatefulWidget {
  const Class1Screen({Key? key}) : super(key: key);

  @override
  _Class1ScreenState createState() => _Class1ScreenState();
}

class _Class1ScreenState extends State<Class1Screen> {
  int _currentPage = 0;
  List<String> _pages = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchImageData();
  }

  Future<void> fetchImageData() async {
    final response = await http.get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=QRaDd5HWwVtjNo83M6DhwSdhxw9M2Ibxj798RL5w'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final imageUrls = data.map<String>((item) => item['url']).toList();
      setState(() {
        _pages = List<String>.from(imageUrls);
      });
    } else {
      throw Exception('Failed to fetch image data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class 1'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else if (details.primaryVelocity! < 0) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Image.network(
                      _pages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Page ${_currentPage + 1} of ${_pages.length}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(16),
              child: _pages.isNotEmpty
                  ? Image.network(
                      _pages[_currentPage],
                      fit: BoxFit.contain,
                    )
                  : CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
