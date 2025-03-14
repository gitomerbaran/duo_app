import 'package:duo_app/screens/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'failure.dart';

class ServerFailure<T> extends Failure<Widget> {
  const ServerFailure(
   {
    required super.details,
    super.actions,
  }) : super(errorObject: const ErrorDialog());
}

class CacheFailure<T> extends Failure<T> {
  const CacheFailure(
    {
    super.details,
    super.errorObject,
    super.actions,
  }) : super();
}

class LanguageFailure<T> extends Failure<T> {
  const LanguageFailure(
     {
    super.details,
    super.errorObject,
    super.actions,
  }) : super();
}

/// İnternet Bağlantısı Yok
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.details = "İnternet bağlantısı yok.",
    super.errorObject,
    super.actions,
  }) : super();
}

/// Kullanıcı Zaten Kayıtlı
class UserAlreadyExistsFailure extends Failure {
  const UserAlreadyExistsFailure({
    super.details = "Bu kullanıcı zaten kayıtlı.",
    super.errorObject,
    super.actions,
  }) : super();
}

/// Form Validasyon Hatası
class ValidationFailure extends Failure {
  const ValidationFailure({
    required String message,
  }) : super(details: message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required String message,
  }) : super(details: message);
}
