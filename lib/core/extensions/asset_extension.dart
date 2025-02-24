import '../constants/enums/icon_enums.dart';
import '../constants/enums/image_enums.dart';

extension IconExtension on IconEnums {
  String get getIcon {
    switch (this) {
      case IconEnums.LOL:
        return "lol_icon.webp";
      case IconEnums.VALORANT:
        return "valorant_icon.png";
      case IconEnums.CS2:
        return "cs2_icon.png";
      case IconEnums.LOL_DIAMOND:
        return "lol_diamond.webp";
      case IconEnums.LOL_GRANDMASTER:
        return "lol_grandmaster.webp";
      case IconEnums.LOL_LANE_BOT:
        return "lol_lane_bot.webp";
      case IconEnums.LOL_LANE_JUNGLE:
        return "lol_lane_jungle.webp";
      case IconEnums.LOL_LANE_SUPPORT:
        return "lol_lane_support.webp";
      case IconEnums.LOL_MASTER:
        return "lol_master.webp";
    }
  }
}

extension ImageExtension on ImageEnums {
  String get getImage {
    switch (this) {
      case ImageEnums.DUO_APP_ONBOARD_1:
        return "duo_app_onboard_1.jpg";
      case ImageEnums.DUO_APP_ONBOARD_2:
        return "duo_app_onboard.webp";
      case ImageEnums.GG:
        return "GG.png";
      case ImageEnums.SPLASH:
        return "splash.png";
    }
  }
}
