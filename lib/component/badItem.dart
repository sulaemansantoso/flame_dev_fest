import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame_devfest/component/item.dart';
import 'package:flutter_flame_devfest/component/player.dart';

class BadItem extends Item {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('bad_item/saw_move.png');
    anchor = Anchor.center;
    size = Vector2(100, 100);
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      game.hurtPlayer();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
