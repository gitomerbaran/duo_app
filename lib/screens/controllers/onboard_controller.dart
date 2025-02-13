import 'package:duo_app/core/cache/hive.dart';
import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/dependency_injection/di.dart';

onboardStateSave() async {
  await getIt<HiveSecureService>().addData(CacheEnums.ONBOARD_CONTROL, true);
}
