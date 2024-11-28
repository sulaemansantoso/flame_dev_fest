import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_devfest/pages/mainGamePage.dart';
import 'package:flame/rendering.dart';

enum PlayerState { idle, walk }

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<MainGamePage> {
  int _live = 1;
  bool isHurt = false;
  int hurtTimer = 0;
  int hurtCD = 10;

  int get live => _live;

  void reset() {
    _live = 1;
    // isHurt = false;
    // hurtTimer = 0;
    // decorator.removeLast();
  }

  void hurt() {
    if (isHurt == false) {
      _live--;
      if (_live == 0) {
        game.gameOver();
      }
      decorator.addLast(PaintDecorator.tint(Colors.red.shade400));
    }
    isHurt = true;
    hurtTimer = 0;
  }

  PlayerState get state => _state;
  set state(PlayerState value) {
    _state = value;
    switch (value) {
      case PlayerState.idle:
        current = PlayerState.idle;
        break;
      case PlayerState.walk:
        current = PlayerState.walk;
        break;
    }
  }

  PlayerState _state = PlayerState.idle;
  Player() : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    final walk = SpriteAnimation.spriteList([
      await game.loadSprite('alienBlue/alienBlue_walk1_edited.png'),
      await game.loadSprite('alienBlue/alienBlue_walk2_edited.png')
    ], stepTime: 1);

    final idle = SpriteAnimation.spriteList(
        [await game.loadSprite('alienBlue/alienBlue_stand_edited.png')],
        stepTime: 1);

    animations = {PlayerState.idle: idle, PlayerState.walk: walk};
    current = PlayerState.idle;

    add(CircleHitbox());
    anchor = Anchor.center;

    await super.onLoad();
  }

  @override
  void update(double dt) {
    if (isHurt == true) {
      hurtTimer++;
      log(hurtTimer.toString());
      if (hurtTimer > hurtCD) {
        log("sembuh");
        hurtTimer = 0;
        isHurt = false;
        decorator.removeLast();
      }
    }

    super.update(dt);
  }
}
