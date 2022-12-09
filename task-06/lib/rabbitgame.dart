import 'dart:ui';

import 'package:flame/game.dart';
import 'package:untitled/bunny.dart';
import 'package:untitled/supplements/directions.dart';
import 'bg.dart';

class Rabbitgame extends FlameGame{
  bunny _bunny = bunny();
  bg _bg = bg();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_bg);
    await add(_bunny);
    _bunny.position = _bg.size / 1.5;
    camera.followComponent(_bunny,
        worldBounds: Rect.fromLTRB(0, 0, _bg.size.x, _bg.size.y));
  }
  onArrowKeyChanged(Direction direction){
    _bunny.direction = direction;
  }
}