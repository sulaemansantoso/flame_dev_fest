import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_devfest/pages/gameOverOverlay.dart';
import 'package:flutter_flame_devfest/pages/mainGamePage.dart';
import 'package:flutter_flame_devfest/pages/startGameOverlay.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    MainGamePage gamePage = MainGamePage();
    return Material(
      child: GameWidget(
        game: gamePage,
        initialActiveOverlays: const ["gameover"],
        overlayBuilderMap: {
          "gameover": (context, game) => Gameoveroverlay(game: gamePage),
          "startgame": (context, game) => StartGameOverlay(game: gamePage),
        },
      ),
    );
  }
}
