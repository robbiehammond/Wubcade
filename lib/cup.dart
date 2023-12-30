import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';

class Cup extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;
  static const double _fillIncreasePercent = 0.1;
  double filledPercent = 0.0;
  late RectangleHitbox hitbox;

  Cup({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size) {
    hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override 
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Droplet) {
      filledPercent += _fillIncreasePercent;
      print(filledPercent);
      /*
        Insert cup filling logic here.
      */
      other.onRemove();
    }
  }
}