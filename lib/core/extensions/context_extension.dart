import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  //height
  double get lowValueSecond => height * 0.015;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;

  double get mediumValue => height * 0.04;
  double get mediumValueSecond => height * 0.05;
  double get mediumValueThird => height * 0.075;

  double get highValue => height * 0.1;
  double get largeValue => height * 0.2;
  double get largeValueSecond => height * 0.25;

  //widht
  double get lowValueWidht => width * 0.1;
  double get normalValueWidht => width * 0.2;
  double get mediumValueWidht => width * 0.3;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension SizedBoxExtensionHeight on BuildContext {
  double get sizedBoxHeightLow => lowValue;
  double get sizedBoxHeightNormal => normalValue;
  double get sizedBoxHeightMedium => mediumValue;
  double get sizedBoxHeightHigh => highValue;
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingMediumSecondHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue / 1.5);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension RandomColorExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);
  Duration get normalDuration => const Duration(seconds: 1);
}

extension ContextWidthHeightExtension on BuildContext {
  double dynamicWidht(double value) => MediaQuery.of(this).size.width * value;
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
}
