import 'package:flutter/material.dart';
import 'package:circles_background/circles_background.dart';

class CareView extends StatelessWidget {
  final AnimationController animationController;

  const CareView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _relaxFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _relaxSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _imageFirstHalfAnimation,
                      child: SlideTransition(
                        position: _imageSecondHalfAnimation,
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 350, maxHeight: 250),
                          child: Image.asset(
                            'lib/assets/onboarding/three.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _relaxFirstHalfAnimation,
                      child: SlideTransition(
                        position: _relaxSecondHalfAnimation,
                        child: Text(
                          "Learn about your context",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 64, right: 64, bottom: 16, top: 16),
                      child: Text(
                        "Focus on the useful vocabulary, the one you will use every day",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
