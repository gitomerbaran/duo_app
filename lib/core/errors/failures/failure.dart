import 'package:duo_app/core/extensions/failure_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../constants/enums/failure_types.dart';
import '../error_widgets/error_dialog.dart';

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

  String get errorMessage => failureType.errorMessage;

  Object get widget => errorObject ?? ErrorDialog();

  List<VoidCallback>? get failureActions => actions;
}
