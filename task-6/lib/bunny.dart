import 'package:flame/components.dart';
import 'package:untitled/supplements/directions.dart';

class bunny extends SpriteComponent with HasGameRef {
  bunny() : super(size: Vector2.all(140.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 3;
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
        position.y -= 12;
        break;
      case Direction.down:
        position.y += 12;
        break;
      case Direction.left:
        position.x -= 12;
        break;
      case Direction.right:
        position.x += 12;
        break;
      case Direction.none:
        break;
    }
  }
}
