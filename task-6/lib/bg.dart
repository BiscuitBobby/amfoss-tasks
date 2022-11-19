import 'package:flame/components.dart';

class bg extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('/assets/images/background.png');
    size = sprite!.originalSize;
  }
}