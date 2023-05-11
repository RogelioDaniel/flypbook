import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

void main() {
  runApp(APODApp());
}

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

class APODHomePage extends StatefulWidget {
  @override
  _APODHomePageState createState() => _APODHomePageState();
}

class _APODHomePageState extends State<APODHomePage> {
  List<String> _apodImageUrls = [];
  String _apodDescription = '';
  DateTime _selectedDate = DateTime.now();

  Future<void> _fetchAPOD(DateTime date) async {
    final apiKey =
        'sB7OLy9bfQSZN60awfxG02UjGkIPPsQITiaPEBGE'; // Replace with your NASA API key
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final url = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$formattedDate');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      setState(() {
        _apodImageUrls.add(decodedResponse['url']);
        _apodDescription = decodedResponse['explanation'];
      });
    } else {
      throw Exception('Failed to fetch APOD');
    }
  }

  Future<void> _setWallpaper(String imageUrl) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDocDir.path}/wallpaper.jpg';

    final response = await http.get(Uri.parse(imageUrl));
    final File imageFile = File(filePath);
    await imageFile.writeAsBytes(response.bodyBytes);

    final wallpaperResult = await WallpaperManager.setWallpaperFromFile(
      filePath,
      WallpaperManager.HOME_SCREEN,
    );
    print(wallpaperResult);
  }

  @override
  void initState() {
    super.initState();
    _fetchAPOD(_selectedDate);
    _fetchAPOD(_selectedDate.subtract(Duration(days: 1)));
    _fetchAPOD(_selectedDate.subtract(Duration(days: 2)));
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
              DateFormat('MMMM d, yyyy').format(_selectedDate),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: _apodImageUrls.length,
            itemBuilder: (BuildContext context, int index, int currentIndex) {
              if (index >= 0 && index < _apodImageUrls.length) {
                return Image.network(_apodImageUrls[index], fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
              } else {
                return CircularProgressIndicator();
              }
            },
            options: CarouselOptions(
              height: 300,
              viewportFraction: 0.8,
              initialPage: 1,
              enableInfiniteScroll: false,
              reverse: true,
              onPageChanged: (index, _) {
                setState(() {
                  _selectedDate =
                      DateTime.now().subtract(Duration(days: index - 1));
                });
                _fetchAPOD(_selectedDate);
              },
            ),
          ),
          SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    _apodDescription,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_apodImageUrls.isNotEmpty) {
                        _setWallpaper(_apodImageUrls[0]);
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
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(1995),
                lastDate: DateTime.now(),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                    _apodImageUrls.clear();
                  });
                  _fetchAPOD(_selectedDate);
                  _fetchAPOD(_selectedDate.subtract(Duration(days: 1)));
                  _fetchAPOD(_selectedDate.subtract(Duration(days: 2)));
                }
              });
            },
            child: Text('Select Date'),
          ),
        ],
      ),
    );
  }
}
