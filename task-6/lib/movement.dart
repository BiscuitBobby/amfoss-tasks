import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

class player extends SpriteComponent with KeyboardHandler{
  static  double _p_x = 25;
  static  double _p_y = 25;
  static  double _p_vel = 12;
  bool _p_left = false;
  bool _p_right = true;
  static  double _p_walkc = 0;  // walkcount
  static  double _p_jumpc = 10;  // jumpcount
  String _p_action = ''  ;
  static const vel = 12;

  static const _size = 100.0;

  Vector2 _position = Vector2.zero();
  Vector2 _movementVector = Vector2.zero();

  @override
  void update(double dt){super.update(dt);}

  bool onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && isKeyDown) {
      _p_x -= vel;
      _p_left = true;
      _p_right = false;
      _p_action = 'walk';
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) && isKeyDown) {
      _p_x += vel;
      _p_left = false;
      _p_right = true;
      _p_action= 'walk';
    }else{
      _p_walkc = 0;
      _p_action = '';
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && isKeyDown) {
      _p_y -= vel;}


    if (keysPressed.contains(LogicalKeyboardKey.arrowDown) && isKeyDown) {
      _p_y += vel;
    }
    return true;
  }}
class SpriteEx extends FlameGame with HasKeyboardHandlerComponents {
  late final player _player;
  @override
  Color backgroundColor() => const Color(0xFF353935);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _player = player();
    await add(_player);}
}
