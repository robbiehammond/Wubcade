import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class Cup extends PositionComponent {
  static final _paint = Paint()..color = Colors.white;

  Cup({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}

class Source extends PositionComponent {
  static final _paint = Paint()..color = Colors.white;

  Source({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  void pour() {
    //leak drop, maybe each pour call leaks one 
  }
}


class Droplet extends PositionComponent {
  static const Color color = Colors.blue;
  static const int DROPLET_WIDTH = 30;
  static const int DROPLET_HEIGHT = 30;

  Droplet(double x, double y) {
    position = Vector2(x, y);
    size = Vector2(30, 30);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += 100 * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw the blue rectangle on the canvas
    final paint = Paint()..color = color;
    canvas.drawRect(size.toRect(), paint);
  }
}

class PouringGame extends FlameGame with TapCallbacks {
  late Cup cup;
  late Source source;


  @override 
  Future<void> onLoad() async {
    await super.onLoad();


    const sourceWidth = 100.0;
    const sourceHeight = 50.0;

    final Vector2 screenSize = size;
    final sourceX = (screenSize.x - sourceWidth) / 2;
    source = Source(
      position: Vector2(sourceX, 0), 
      size: Vector2(sourceWidth, sourceHeight));


    const cupWidth = 100.0;
    const cupHeight = 50.0;

    final cupY = screenSize.y - cupHeight;
    cup = Cup(
      position: Vector2(sourceX, cupY), 
      size: Vector2(cupWidth, cupHeight));

    add(source);
    add(cup);
  }

  @override
  void onTapDown(TapDownEvent event) {
      //15 comes from the natural droplet size
      Droplet d = Droplet(source.x + (source.width / 2) - (Droplet.DROPLET_WIDTH) / 2, source.y);
      add(d);
  }
}

void main() {
  runApp(GameWidget(game: PouringGame()));
}