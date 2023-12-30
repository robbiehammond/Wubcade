import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wubcade/cup.dart';

class Droplet extends PositionComponent with CollisionCallbacks {
  static const Color color = Colors.blue;
  static const double dropletWidth = 30.0;
  static const double dropletHeight = 30.0;
  static const int _fallSpeed = 200; //should be adjusted as we like.
  bool enteredCupHasNotHitBottom = false;
  late RectangleHitbox hitbox;

  Droplet({
    required Vector2 position,
  }) : super(position: position, size: Vector2(dropletWidth, dropletHeight)) {
    hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += _fallSpeed * dt;

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = color;
    canvas.drawRect(size.toRect(), paint);
  }

  @override 
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (enteredCupHasNotHitBottom) removeFromParent();
    if (other is Cup) removeFromParent();
  }
}