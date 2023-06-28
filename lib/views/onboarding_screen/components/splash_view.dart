import 'package:flutter/material.dart';
import 'package:circles_background/circles_background.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _introductionAnimation;

  @override
  void initState() {
    _animationController = widget.animationController;
    _introductionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0.0, -1.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _introductionAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B79A1), Color(0xFF283E51)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            CirclesBackground(
              circles: [
                CircleInfo(
                  color: Colors.white.withOpacity(0.2),
                  size: Size(260, 260),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'lib/assets/onboarding/first.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "FlypBook",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Focus on what matters to you.",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48.0),
                    InkWell(
                      onTap: () {
                        _animationController.animateTo(0.2);
                      },
                      child: Container(
                        height: 58,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 56.0, vertical: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38.0),
                          color: Color(0xFF132137),
                        ),
                        child: Center(
                          child: Text(
                            "Let's begin",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
