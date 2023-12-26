import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Droplet extends PositionComponent {
  static const Color color = Colors.blue;
  static const double dropletWidth = 30.0;
  static const double dropletHeight = 30.0;

  Droplet({
    required Vector2 position,
  }) : super(position: position, size: Vector2(dropletWidth, dropletHeight));


  @override
  void update(double dt) {
    super.update(dt);

    position.y += 100 * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = color;
    canvas.drawRect(size.toRect(), paint);
  }
}