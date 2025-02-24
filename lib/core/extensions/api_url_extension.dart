
import '../constants/enums/api_enums.dart';

extension ApiExtension on ApiEnums {
  enumToURL() {
    switch (this) {
      case ApiEnums.LOGIN:
        return "";
      case ApiEnums.REGISTER:
        return "";
      case ApiEnums.VERSION_CONTROL:
        return "";
    }
  }
}
