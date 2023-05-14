import 'package:flutter/material.dart';
import 'package:flypbook/views/all_items_screen.dart';
import 'package:flypbook/views/onboarding_screen.dart';
import 'package:circles_background/circles_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingShown = prefs.getBool('onboarding_shown') ?? false;

  runApp(MyApp(onboardingShown: onboardingShown));
}

class MyApp extends StatelessWidget {
  final bool onboardingShown;

  const MyApp({required this.onboardingShown});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: onboardingShown ? AllItemsScreen() : OnboardingScreen(),
    );
  }
}
