import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_devfest/component/background.dart';
import 'package:flutter_flame_devfest/component/itemSpawner.dart';
import 'package:flutter_flame_devfest/component/player.dart';
import 'package:flutter_flame_devfest/component/uiComponent.dart';

class MainGamePage extends FlameGame with TapDetector, HasCollisionDetection {
  @override
  onMount() {
    pauseEngine();
    super.onMount();
  }

  late Player p = Player();
  late Background bg = Background();
  late Itemspawner sp = Itemspawner();
  late UiComponent ui = UiComponent();

  @override
  Color backgroundColor() {
    return Colors.red.shade400;
  }

  void gameOver() {
    overlays.add("gameover");
    pauseEngine();
  }

  void hurtPlayer() {
    p.hurt();
    ui.changeLive(p.live);
  }

  void addScore() {
    ui.addScore(10);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (info.eventPosition.global.x < p.position.x) {
      p.state = PlayerState.walk;
      p.position -= Vector2(100, 0);
    } else {
      p.state = PlayerState.walk;
      p.position += Vector2(100, 0);
    }

    super.onTapDown(info);
  }

  @override
  FutureOr<void> onLoad() {
    Vector2 gameSize = size;

    add(bg);
    p = Player()
      ..position = Vector2(gameSize.x / 2, gameSize.y - 80)
      ..size = Vector2(128, 160);
    add(p);
    add(sp);
    add(ui);
    ui.changeLive(p.live);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    p.position = Vector2(size.x / 2, size.y - 80);

    double bgSizeX = size.x > 512 ? size.x : 512;
    double bgSizeY = size.y > 512 ? size.y : 512;

    bg.size = Vector2(bgSizeX, bgSizeY);
    super.onGameResize(size);
  }

  void reset() {
    p.position = Vector2(size.x / 2, size.y - 80);
    p.size = Vector2(128, 160);
    p.reset();

    ui.changeLive(p.live);
    ui.resetScore();

    sp.reset();
  }
}
