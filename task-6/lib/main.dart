import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:untitled/supplements/navigation_keys.dart';
import 'rabbitgame.dart';

void main() {
  final game = Rabbitgame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: NavigationKeys(
                onDirectionChanged: game.onArrowKeyChanged,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
