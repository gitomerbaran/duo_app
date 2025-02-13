import 'package:duo_app/core/constants/enums/failure_types.dart';
import 'package:duo_app/core/errors/failures/failure.dart';
import 'package:flutter/material.dart';

class ServerFailure<T> extends Failure<T> {
  const ServerFailure({
    String? details,
    T? errorObject,
    List<VoidCallback>? actions,
  }) : super(
          failureType: FailureType.serverError,
          details: details,
          errorObject: errorObject,
          actions: actions,
        );
}

class CacheFailure<T> extends Failure<T> {
  const CacheFailure(String s, {
    String? details,
    T? errorObject,
    List<VoidCallback>? actions,
  }) : super(
          failureType: FailureType.cacheError,
          details: details,
          errorObject: errorObject,
          actions: actions,
        );
}

class LanguageFailure<T> extends Failure<T> {
  const LanguageFailure(String s, {
    String? details,
    T? errorObject,
    List<VoidCallback>? actions,
  }) : super(
          failureType: FailureType.unexpectedError,
          details: details,
          errorObject: errorObject,
          actions: actions,
        );
}
