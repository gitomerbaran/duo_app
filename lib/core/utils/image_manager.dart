import '../constants/assets/assets_constants.dart';

class ImageManager {
  static ImageManager? _instance;

  static ImageManager get instance {
    if (_instance == null) return _instance = ImageManager._init();
    return _instance!;
  }

  String toPng(String item) => "${ImageConstants.IMAGE_PATH}$item";

  ImageManager._init();
}
