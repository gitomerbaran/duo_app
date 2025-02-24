import '../constants/icons/icon_constants.dart';

class IconManager {
  static IconManager? _instance;

  static IconManager get instance {
    if (_instance == null) return _instance = IconManager._init();
    return _instance!;
  }

  String toPng(String item) => "${IconConstants.ICON_PATH}$item";

  IconManager._init();
}
