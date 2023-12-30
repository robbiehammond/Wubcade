import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wubcade/cup.dart';
import 'package:wubcade/source.dart';

//TODO: collision detection between water and cup not actually doing anything right now. Not sure why.
class Droplet extends PositionComponent with CollisionCallbacks {
  static const Color color = Colors.blue;
  static const double dropletWidth = 30.0;
  static const double dropletHeight = 30.0;
  late RectangleHitbox hitbox;

  Droplet({
    required Vector2 position,
  }) : super(position: position, size: Vector2(dropletWidth, dropletHeight)) {
    hitbox = RectangleHitbox();
    add(hitbox);
  }

  @override 
  void onRemove() {
    super.onRemove();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 200 * dt; //speed should be adjusted.
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
    if (other is Cup) removeFromParent();
  }
}