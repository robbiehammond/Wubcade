import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'cup.dart';
import 'source.dart';

class PouringGame extends FlameGame with TapCallbacks {
  late Cup cup;
  late Source source;

  @override 
  Future<void> onLoad() async {
    await super.onLoad();

    //arbitrary, should be changed later.
    const double sourceWidth = 100.0;
    const double sourceHeight = 50.0;
    const double cupWidth = 100.0;
    const double cupHeight = 50.0;

    final Vector2 screenSize = size;

    final sourceX = (screenSize.x - sourceWidth) / 2;
    source = Source(
      position: Vector2(sourceX, 0), 
      size: Vector2(sourceWidth, sourceHeight));



    final cupY = screenSize.y - cupHeight;
    cup = Cup(
      position: Vector2(sourceX, cupY), 
      size: Vector2(cupWidth, cupHeight));

    add(source);
    add(cup);
  }

  @override
  void onTapDown(TapDownEvent event) {
    source.startPouring();
  }

  @override
  void onTapUp(TapUpEvent event) {
    source.stopPouring();
  }
}

void main() {
  runApp(GameWidget(game: PouringGame()));
}