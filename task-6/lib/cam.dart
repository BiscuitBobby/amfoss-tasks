import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'rabbitgame.dart';

void main() {
  final game = Rabbitgame();
  runApp(
    GameWidget(game: game),
  );
}