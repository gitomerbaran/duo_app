// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LanguageCodeEnum {
  TR(Locale('tr', 'TR')),
  EN(Locale('en', 'US'));

  final Locale locale;

  const LanguageCodeEnum(this.locale);
}
