import 'dart:convert';
import 'dart:typed_data';

import 'package:duo_app/core/constants/enums/cache_enums.dart';
import 'package:duo_app/core/errors/failures/failure.dart';
import 'package:duo_app/core/extensions/_core_extension_exports.dart';
import 'package:either_dart/either.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../errors/failure_types/failure_types.dart';
import 'cache_service.dart';

class HiveSecureService implements CacheService {
  static final HiveSecureService _instance = HiveSecureService._internal();
  factory HiveSecureService() => _instance;

  HiveSecureService._internal();

  static const String _secureKeyName = 'taner_taner';
  Box? _cacheBox;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Hive başlatılır ve şifreleme için anahtar oluşturulur.
  @override
  Future<void> init() async {
    if (_cacheBox != null) return; // Eğer zaten başlatıldıysa tekrar başlatma

    await Hive.initFlutter();
    final encryptionKey = await _getEncryptionKey();
    _cacheBox = await Hive.openBox(
      'secureCacheBox',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    print("✅ HiveSecureService Başlatıldı!");
  }

  Future<Uint8List> _getEncryptionKey() async {
    final existingKey = await _secureStorage.read(key: _secureKeyName);
    if (existingKey != null) {
      return Uint8List.fromList(base64Decode(existingKey));
    } else {
      final newKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: _secureKeyName,
        value: base64Encode(newKey),
      );
      return Uint8List.fromList(newKey);
    }
  }

  /// Tüm `try-catch` işlemlerini yönetmek için genel bir `safeCall` metodu
  Future<Either<Failure, T>> _safeCall<T>(Future<T> Function() action) async {
    try {
      if (_cacheBox == null) {
        print("⚠️ Cache başlatılmadı!");
        return Left(CacheFailure("Cache başlatılmadı"));
      }

      return Right(await action());
    } catch (e) {
      print("🚨 Cache Hatası: $e");
      return Left(CacheFailure("Cache hatası: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> addData<T>(CacheEnums key, T value) async {
    return _safeCall(() async {
      print("💾 Cache'e veri ekleniyor: ${key.cacheKeyToValue()} -> $value");
      await _cacheBox!.put(key.cacheKeyToValue(), value);
    });
  }

  @override
  Future<Either<Failure, T>> getData<T>(CacheEnums key) async {
    return _safeCall(() async {
      print("📦 Cache'den veri okunuyor: ${key.cacheKeyToValue()}");
      final data = _cacheBox!.get(key.cacheKeyToValue());

      if (data != null) {
        print("✅ Cache verisi bulundu: $data");
        return data as T;
      } else {
        print("❌ Cache'de veri bulunamadı!");
        throw Exception("Cache'de veri bulunamadı");
      }
    });
  }

  @override
  Future<Either<Failure, void>> removeData(CacheEnums key) async {
    return _safeCall(() async {
      print("🗑️ Cache'den veri siliniyor: ${key.cacheKeyToValue()}");
      await _cacheBox!.delete(key.cacheKeyToValue());
    });
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    return _safeCall(() async {
      print("🧹 Cache tamamen temizleniyor...");
      await _cacheBox!.clear();
    });
  }
}
