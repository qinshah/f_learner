import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/brick_breaker.dart';
import 'src/widgets/game_app.dart';

class FlamePage extends StatefulWidget {
  const FlamePage({super.key});

  @override
  State<FlamePage> createState() => _FlamePageState();
}

class _FlamePageState extends State<FlamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flame游戏')),
      body: GameApp(),
    );
  }
}
