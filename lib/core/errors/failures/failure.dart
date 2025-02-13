// core/errors/failures.dart
import 'package:duo_app/core/constants/enums/failure_types.dart';
import 'package:duo_app/core/errors/error_widgets/error_dialog.dart';
import 'package:duo_app/core/extensions/failure_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure<T> extends Equatable {
  final FailureType failureType;
  final String? details;
  final T? errorObject; 
  final List<VoidCallback>? actions; 

  const Failure({
    required this.failureType,
    this.details,
    this.errorObject,
    this.actions,
  });

  @override
  List<Object?> get props => [failureType, details, errorObject, actions];

  /// Varsayılan hata mesajını döndürür.
  String get errorMessage => failureType.errorMessage;

  /// Varsayılan widget veya error bileşeni döndürür.
  Object get widget => errorObject ?? ErrorDialog();

  /// Varsayılan aksiyonları döndürür.
  List<VoidCallback>? get failureActions => actions;
}
