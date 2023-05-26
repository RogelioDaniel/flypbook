import 'package:flutter/material.dart';
import 'package:flypbook/views/main_screen.dart';
import 'package:flypbook/views/onboarding_screen/introduction_animation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingShown = prefs.getBool('onboarding_shown') ?? false;

  runApp(MyApp(onboardingShown: onboardingShown));
}

class MyApp extends StatelessWidget {
  final bool onboardingShown;

  const MyApp({super.key, required this.onboardingShown});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // Add GestureDetector to handle tap anywhere on the screen
        onTap: () {
          // Unfocus text field and dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp(
          title: 'Flypbook',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: onboardingShown
              ? const AllItemsScreen()
              : const IntroductionAnimationScreen(),
        ));
  }
}
