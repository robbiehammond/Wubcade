import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Cup extends PositionComponent {
  static final _paint = Paint()..color = Colors.red;

  Cup({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}