import 'package:flutter/material.dart';
import 'package:flypbook/views/idioms_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: '',
      title: 'Welcome to FlypBook',
      description: 'Focus on what matters to you.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      title: 'Learn at your own pace',
      description: 'And practice in your free time.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      title: 'Get Started Now',
      description: 'Your context is the learning base, focus!!!.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool('onboarding_shown') ?? false;
    if (onboardingShown) {
      // Onboarding already shown, navigate to the next page
      _navigateToNextPage();
    }
  }

  Future<void> _markOnboardingAsShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_shown', true);
  }

  void _navigateToNextPage() {
    if (_currentPageIndex < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Perform any action or navigate to the next page after onboarding
      _markOnboardingAsShown(); // Mark onboarding as shown
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IdiomsScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/8715883.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 254, 254, 0.2),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardingItems.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = _onboardingItems[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final maxWidth = constraints.maxWidth;
                              final maxHeight = constraints.maxHeight;

                              final imageHeight = maxWidth * 1.6;
                              final imageWidth = maxWidth * 1.6;

                              return Image.asset(
                                item.image,
                                height: imageHeight,
                                width: imageWidth,
                              );
                            },
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.5
                                ..color = const Color.fromARGB(255, 18, 17, 17),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final maxWidth = constraints.maxWidth;

                              return Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: maxWidth * 0.04,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPageIndex > 0)
                        TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      if (_currentPageIndex < _onboardingItems.length - 1)
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextPage();
                          },
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      if (_currentPageIndex == _onboardingItems.length - 1)
                        ElevatedButton(
                          onPressed: () {
                            _navigateToNextPage();
                          },
                          child: Text('Get Started'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
