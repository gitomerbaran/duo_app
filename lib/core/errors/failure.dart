import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../screens/widgets/error_dialog.dart';

abstract class Failure<T> extends Equatable {
  final String? details;
  final T? errorObject;
  final VoidCallback? actions;
  final String? dialogTitle;

  const Failure(
      {this.details, this.errorObject, this.actions, this.dialogTitle});

  @override
  List<Object?> get props => [details, errorObject, actions];

  Widget get errorWidget => ErrorDialog(
        title: dialogTitle,
        message: details ?? "Bilinmeyen bir hata oluştu!",
      );

  VoidCallback? get failureActions => actions;
}
