import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'droplet.dart';

class Source extends PositionComponent {
  static final _paint = Paint()..color = Colors.yellow;
  int _dropletsPoured = 0;
  bool shouldPour = false;
  bool hasPouredBeforeReset = false;

  Source({
    required Vector2 position,
    required Vector2 size, 
  }) : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldPour) pour();

  }

  void pour() {
    Droplet d = Droplet(position: Vector2(position.x + width / 2 - Droplet.dropletWidth / 2, position.y + height));
    parent?.add(d);
    _dropletsPoured += 1;
    hasPouredBeforeReset = true;
  }

  void startPouring() {
    shouldPour = true;
  }

  void stopPouring() {
    shouldPour = false;
  }

  void reset() {
    _dropletsPoured = 0;
    hasPouredBeforeReset = false;
  }

  int getPourAmount() {
    return _dropletsPoured;
  }

  bool hasPouredThisTurn() {
    return hasPouredBeforeReset;
  }
}