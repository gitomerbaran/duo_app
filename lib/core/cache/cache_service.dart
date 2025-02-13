// core/cache/cache_service.dart
import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/errors/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class CacheService {
  Future init();
  Future<Either<Failure, void>> addData<T>(CacheEnums key, T value);
  Future<Either<Failure, T>> getData<T>(CacheEnums key);
  Future<Either<Failure, void>> removeData(CacheEnums key);
  Future<Either<Failure, void>> clearAll();
}
