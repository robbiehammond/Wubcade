import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';
import 'dart:math';
import 'dart:core';

class Cup extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;
  static const double _fillIncreasePercent = 0.1;
  double filledPercent = 0.0;
  int _dropletsCollected = 0;
  int amountPoured = -1;
  late double _percentToFillTo;
  late RectangleHitbox hitbox;
  final void Function() onFinishFilling;
  Cup({
    required Vector2 position,
    required Vector2 size, 
    required this.onFinishFilling
  }) : super(position: position, size: size) {
    hitbox = RectangleHitbox();
    add(hitbox);

    Random r = new Random();
    _percentToFillTo = r.nextInt(91) + 5; // 5% <= _percentToFillTo <= 95%

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
      _dropletsCollected += 1;
      if (_dropletsCollected == amountPoured) {
        onFinishFilling();
      }
      /*
        Insert cup filling logic here.
      */
      print(_dropletsCollected);
      print(amountPoured);
      other.onRemove();
    }
  }

  double correctness() {
    return (_percentToFillTo - filledPercent).abs();
  }

  //likely will be removed when we have the conveyour belt. There will just be many cups instead.
  void reset() {
    Random r = new Random();
    _percentToFillTo = r.nextInt(91) + 5; // 5% <= _percentToFillTo <= 95%
    filledPercent = 0.0;
    _dropletsCollected = 0;
    amountPoured = -1;
  }

  void giveCorrectFillAmount(int amt) {
    amountPoured = amt;
  }
}