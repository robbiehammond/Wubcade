import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';

class Source extends PositionComponent {
  static final _paint = Paint()..color = Colors.yellow;
  bool shouldPour = false;

  Source({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size);

  void pour() {
    //width / 2 gets the left edge of the drop to the middle of the source, Droplet.dropletWidth / 2 lines them up by their centers.
    Droplet d = Droplet(position: Vector2(width / 2 - Droplet.dropletWidth / 2, height));
    add(d);
  }


  void startPouring() {
    shouldPour = true;
  }

  void stopPouring() {
    shouldPour = false;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }


  @override
  void update(double dt) {
    super.update(dt);
    if (shouldPour) {
      pour(); //pour rate might need to be tweaked.
    }
  }
}