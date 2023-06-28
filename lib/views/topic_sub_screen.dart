import 'package:flutter/material.dart';
import 'package:flypbook/models/topic_item.dart';
import 'package:circles_background/circles_background.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_mob_service.dart';

class TopicSubScreen extends StatefulWidget {
  final TopicItem topicItem;

  const TopicSubScreen({Key? key, required this.topicItem}) : super(key: key);

  @override
  _TopicSubScreenState createState() => _TopicSubScreenState();
}

class _TopicSubScreenState extends State<TopicSubScreen> {
  BannerAd? _banner;

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
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.topicItem.title),
          ),
          extendBodyBehindAppBar: false,
          body: CirclesBackground(
            circles: [
              CircleInfo(
                size: const Size(300, 500),
                color: const Color.fromARGB(255, 139, 139, 139),
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(200)),
                alignment: Alignment.topRight,
              ),
              CircleInfo(
                size: const Size(300, 900),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 138, 138, 138),
                    Color.fromARGB(255, 97, 97, 97),
                  ],
                ),
                borderRadius: const BorderRadius.only(),
                alignment: Alignment.topLeft,
              ),
              CircleInfo(
                size: const Size(200, 500),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 138, 138, 138),
                    Color.fromARGB(255, 97, 97, 97),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(150),
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget.topicItem.image,
                      height: constraints.maxHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.topicItem.title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.topicItem.description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.topicItem.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.topicItem.items[index];
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16.0),
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[800],
                                ),
                              ),
                              onTap: () {
                                // Navigate to subtopic screen
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_banner != null)
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            height: 52,
                            child: AdWidget(ad: _banner!),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
