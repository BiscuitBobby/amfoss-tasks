import 'package:flame/components.dart';
import 'package:untitled/supplements/directions.dart';

class bunny extends SpriteComponent with HasGameRef {
  bunny() : super(size: Vector2.all(100.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('/assets/images/player.png');
    position = gameRef.size / 2;

  }
  Direction direction = Direction.none;

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y --;
        break;
      case Direction.down:
        position.y ++;
        break;
      case Direction.left:
        position.x --;
        break;
      case Direction.right:
        position.x ++;
        break;
      case Direction.none:
        break;
    }
  }
}
