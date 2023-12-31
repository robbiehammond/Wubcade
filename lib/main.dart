import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'cup.dart';
import 'source.dart';

class PouringGame extends FlameGame with TapCallbacks, DragCallbacks, HasCollisionDetection {
  late Cup cup;
  late Source source;
  late Vector2 screenSize;

  @override 
  Future<void> onLoad() async {
    await super.onLoad();

    //arbitrary, should be changed later.
    const double sourceWidth = 100.0;
    const double sourceHeight = 50.0;
    const double cupWidth = 100.0;
    const double cupHeight = 50;

    screenSize = size;

    final double cupYOffset = screenSize.y / 10; //make it 1/10 up the screen
    final double sourceYOffset = screenSize.y / 10; //make it 1/10 down the screen
    final sourceX = (screenSize.x - sourceWidth) / 2;
    source = Source(
      position: Vector2(sourceX, sourceYOffset), 
      size: Vector2(sourceWidth, sourceHeight)
    );



    final cupY = screenSize.y - cupHeight - cupYOffset;
    cup = Cup(
      position: Vector2(sourceX, cupY), 
      size: Vector2(cupWidth, cupHeight),
      onFinishFilling: checkCorrectness
    );

    add(source);
    add(cup);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!source.hasPouredThisTurn()) source.startPouring();
  }

  @override
  void onTapUp(TapUpEvent event) {
    source.stopPouring();
    cup.getCorrectFillAmount(source.getPourAmount());
  }

  @override
  void onDragEnd(DragEndEvent e) {
    super.onDragEnd(e);
    source.stopPouring();
    cup.getCorrectFillAmount(source.getPourAmount());
  }

  void checkCorrectness() {
    print(cup.correctness());
    resetGame();
  }

  void resetGame() {
    cup.reset();
    source.reset();
    double amt = cup.getPercentToFillTo();
    print("New percent to fill to: $amt");
  }
}

/*
  How stream and correctness work:
    1. When stream starts (determined by source.startPouring), a count begins 
       for the amount of drops that have left the source.
    2. When stream hits cup, a count begins at the cup for how many drops it has collected.
    3. Once stream stops (determined by source.stopPouring), the cup receives the amount of water that has been poured
       (cup.getCorrectFillAmount(source.getPourAmount())).
    4. The cup will continue counting the received drops like normal until the amount it 
       has collected is equal to the amount that has been poured (Note: before the correct
       fill amount has been assigned, it's listed as -1. This is so that the equality between
       the amount of water poured and the amount of water collected can't be equal until the 
       amount poured is learned by the cup)
    5. Once the cup has collected all drops that have been poured, a function defined in the FlameGame
       is called, essentially through a function pointer passed during the construction of the cup.
       This function checks correctness and continues the game.

*/  

void main() {
  runApp(GameWidget(game: PouringGame(), ));
}