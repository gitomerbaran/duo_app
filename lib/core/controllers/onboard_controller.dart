import '../cache/hive.dart';
import '../constants/enums/cache_enums.dart';
import '../dependency_injection/di.dart';

onboardStateSave() async {
  await getIt<HiveSecureService>().addData(CacheEnums.ONBOARD_CONTROL, true);
}
