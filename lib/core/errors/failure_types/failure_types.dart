import 'package:flutter/material.dart';
import '../../constants/enums/failure_types.dart';
import '../failures/failure.dart';

class ServerFailure<T> extends Failure<T> {
  const ServerFailure(String s, {
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
  const CacheFailure(
    String text, {
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
  const LanguageFailure(
    String text, {
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
