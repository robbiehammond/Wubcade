import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';
import 'dart:math';
import 'dart:core';
import 'dart:developer' as developer;

class Cup extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;

  int _dropletsCollected = 0;
  int _dropletsNeeded = 0;
  int amountPoured = -1;
  bool filledWithAllPouredWater = false;

  late RectangleHitbox hitbox;

  final void Function() onFinishFilling;

  Cup({
    required Vector2 position,
    required Vector2 size, 
    required this.onFinishFilling
  }) : super(position: position, size: size) {
    hitbox = RectangleHitbox();
    add(hitbox);

    _dropletsNeeded = potentialNewNeededDropletAmount();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override 
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Droplet) {
      _dropletsCollected += 1;
      if (_dropletsCollected == amountPoured) {
        filledWithAllPouredWater = true;
        onFinishFilling();
      }
      /*
        Insert cup filling logic here.
      */
      other.onRemove();
    }
  }

  double percentError() {
    assert(amountPoured != -1);
    developer.log("$_dropletsCollected, $_dropletsNeeded");
    double percentError = ((_dropletsCollected - _dropletsNeeded).abs() / _dropletsNeeded) * 100;
    return percentError;
  }

  int potentialNewNeededDropletAmount() {
    Random r = new Random();
    return r.nextInt(91) + 5; // 5% <= needed droplets <= 95%
  }

  //likely will be removed when we have the conveyour belt. There will just be many cups instead.
  void reset() {
    _dropletsNeeded = potentialNewNeededDropletAmount();
    _dropletsCollected = 0;
    amountPoured = -1;
    filledWithAllPouredWater = false;
  }

  void getCorrectFillAmount(int amt) {
    amountPoured = amt;
  }

  int getDropletsNeeded() {
    if (filledWithAllPouredWater) {
      developer.log("Note: getting the percent to fill to after water has been poured. Should this really be happening?");
    }
    return _dropletsNeeded;
  }
}