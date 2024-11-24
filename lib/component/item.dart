import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame_devfest/component/player.dart';
import 'package:flutter_flame_devfest/pages/mainGamePage.dart';

class Item extends SpriteComponent
    with HasGameRef<MainGamePage>, CollisionCallbacks {
  double speed = 1;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('item/coinGold.png');
    anchor = Anchor.center;
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      game.addScore();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.y += speed;

    if (position.y > game.size.y) removeFromParent();
    super.update(dt);
  }
}
