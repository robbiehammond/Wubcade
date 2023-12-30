import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:wubcade/droplet.dart';
import 'cup.dart';
import 'source.dart';

class PouringGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Cup cup;
  late Source source;
  late Vector2 screenSize;

  @override 
  Future<void> onLoad() async {
    await super.onLoad();

    //arbitrary, should be changed later.
    const double sourceWidth = 100.0;
    const double sourceHeight = 50.0;
    const double cupWidth = 100.0;
    const double cupHeight = 50.0;

    screenSize = size;

    final sourceX = (screenSize.x - sourceWidth) / 2;
    source = Source(
      position: Vector2(sourceX, 0), 
      size: Vector2(sourceWidth, sourceHeight));



    final cupY = screenSize.y - cupHeight;
    cup = Cup(
      position: Vector2(sourceX, screenSize.y / 4), 
      size: Vector2(cupWidth, cupHeight));

    add(source);
    add(cup);
  }

  @override
  void onTapDown(TapDownEvent event) {
    pourOne();
  }

  @override
  void onTapUp(TapUpEvent event) {
    //stopPour();
  }

  void pourOne() {
    add(Droplet(position: Vector2(screenSize.x / 2, 0)));
  }
}

void main() {
  runApp(GameWidget(game: PouringGame()));
}