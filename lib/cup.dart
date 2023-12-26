import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';

//TODO: collision detection between water and cup not actually doing anything right now. Not sure why.
class Cup extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;

  Cup({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size) {
    add(RectangleHitbox(position: position, size: size));
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override 
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Droplet) {
      print("water just fell on me");
    }
  }
}