import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/ad_mob_service.dart';
import 'package:flypbook/views/topic_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final String itemId;
  final String id;
  final String image;
  final String title;
  final String description;

  const ItemDetailScreen({
    required this.itemId,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  BannerAd? _banner;
  String selectedText = '';
  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 229, 210, 210).withOpacity(0.3),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 229, 210, 210)
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: const Color.fromARGB(255, 23, 23, 23),
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Mini ventana emergente'),
                                  content:
                                      Text('Contenido de la ventana emergente'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SelectableText(
                            widget.description,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              letterSpacing: 0.8,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                SizedBox(height: 16.0),
                Divider(
                  height: 1.0,
                  color: Colors.grey[300],
                  thickness: 1.0,
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: TopicScreen(itemId: widget.itemId),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_banner != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 50,
                        child: AdWidget(ad: _banner!),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> translateText(String text, String targetLanguage) async {
    final apiKey =
        'AIzaSyA5m1Nc8ws2BbmPRwKu5gFradvD_hgq6G0'; // Reemplaza con tu propia clave de API de Google Translate
    const to = 'es';
    const text = 'hola';
    final url =
        Uri.parse('https://translation.googleapis.com/language/translate/v2');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'target': targetLanguage,
        'key': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      final translatedText = jsonDecode(response.body)['data']['translations']
          [0]['translatedText'];
      return translatedText;
    } else {
      throw Exception('Failed to translate text');
    }
  }

  void onTapText() {
    setState(() {
      selectedText = getSelectedText();
    });
    translateSelectedText();
  }

  String getSelectedText() {
    final selection = TextSelection.fromPosition(
      TextPosition(offset: widget.description.length),
    );
    final selectedText = selection.textInside(widget.description);
    return selectedText;
  }

  void translateSelectedText() async {
    final translatedText = await translateText(selectedText, 'es');
    print('Selected Text: $selectedText');
    print('Translation: $translatedText');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Translation'),
          content: Text(translatedText),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
