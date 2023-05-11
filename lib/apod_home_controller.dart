import 'dart:ui';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class APODHomeController {
  List<String> apodImageUrls = [];
  String apodDescription = '';
  DateTime selectedDate = DateTime.now();
  VoidCallback updateStateCallback;

  APODHomeController({required this.updateStateCallback});

  Future<void> fetchAPOD(DateTime date) async {
    try {
      const apiKey = 'sB7OLy9bfQSZN60awfxG02UjGkIPPsQITiaPEBGE';
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final url = Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$formattedDate');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        apodImageUrls.add(decodedResponse['url']);
        apodDescription = decodedResponse['explanation'];
      } else {
        throw Exception('Failed to fetch APOD');
      }
    } catch (e) {
      print('Error fetching APOD: $e');
      throw Exception('Failed to fetch APOD');
    }
  }

  Future<void> setWallpaper(String imageUrl) async {
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

  void setSelectedDate(int index) {
    selectedDate = DateTime.now().subtract(Duration(days: index - 1));
    fetchAPOD(selectedDate);
  }
}
