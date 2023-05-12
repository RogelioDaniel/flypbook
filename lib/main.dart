import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(GameWrapper());
}

class MyGame extends Game {
  late Size screenSize;
  late Rect characterRect;
  late Rect enemyRect;
  late double tileSize;
  late Paint characterPaint;
  late Paint enemyPaint;

  @override
  Future<void> onLoad() async {
    characterPaint = Paint()..color = Colors.blue;
    enemyPaint = Paint()..color = Colors.red;

    characterRect = Rect.fromLTWH(
      0,
      0,
      tileSize,
      tileSize,
    );

    enemyRect = Rect.fromLTWH(
      screenSize.width - tileSize,
      screenSize.height - tileSize,
      tileSize,
      tileSize,
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(characterRect, characterPaint);
    canvas.drawRect(enemyRect, enemyPaint);
  }

  @override
  void update(double dt) {}

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    double x = d.globalPosition.dx;
    double y = d.globalPosition.dy;

    if (characterRect.contains(Offset(x, y))) {
      print('Character tapped!');
    }
  }

  void onPanUpdate(DragUpdateDetails d) {
    characterRect = characterRect.translate(d.delta.dx, d.delta.dy);
  }
}

class GameWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        MyGame().onTapDown(details);
      },
      onPanUpdate: (DragUpdateDetails details) {
        MyGame().onPanUpdate(details);
      },
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: GameWidget(game: MyGame()),
            ),
          ),
        ),
      ),
    );
  }
}
