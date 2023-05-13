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
      image: 'assets/images/onboarding1.png',
      title: 'Welcome to MyApp',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      title: 'Explore Amazing Features',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      title: 'Get Started Now',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
      backgroundColor: Colors.white, // Set the background color
      body: PageView.builder(
        controller: _pageController,
        itemCount: _onboardingItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _onboardingItems[index];
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.image,
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(height: 32.0),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  item.description,
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
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
                      color: Colors.blue), // Set the button text color
                ),
              ),
            if (_currentPageIndex < _onboardingItems.length - 1)
              ElevatedButton(
                onPressed: () {
                  _navigateToNextPage();
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set the button background color
                ),
              ),
            if (_currentPageIndex == _onboardingItems.length - 1)
              ElevatedButton(
                onPressed: () {
                  _navigateToNextPage();
                },
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set the button background color
                ),
              ),
          ],
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
