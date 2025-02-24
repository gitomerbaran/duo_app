
import '../constants/enums/cache_enums.dart';

/// The extension [CacheExtension] on [CacheEnums] syntax in Dart is used to add new
/// functionality or methods to an existing class or enum without modifying the original class or enum
/// itself. In this case, the extension [CacheEnumsExtension] is adding a method
/// [sharedKeyStateToKeyValues] to the [CacheEnums] enum.

extension CacheExtension on CacheEnums {
  String cacheKeyToValue() {
    switch (this) {
      case CacheEnums.LANGUAGE_SETTINGS:
        return "LANGUAGE_SETTINGS";
      case CacheEnums.THEMA_SETTINGS:
        return "THEMA_SETTINGS";
      case CacheEnums.INIT_APP:
        return "INIT_APP";
      case CacheEnums.FAILED_LOAD_DATA:
        return "FAILED_LOAD_DATA";
      case CacheEnums.TOKEN:
        return "TOKEN";
      case CacheEnums.ONBOARD_CONTROL:
        return "ONBOARD_CONTROL";
    }
  }
}
