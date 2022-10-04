import 'package:flutter/material.dart';

import 'color.dart';

/// This are the fonts defined
/// [here](https://n09gne.axshare.com/#g=51&id=wihn0b&p=overview_designelements)
/// under the `Common` section
extension BahagTextStyles on TextTheme {
  static const _fontFamily = 'Taz';

  /// Headline styles
  TextStyle get headline1 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        height: 35 / 30,
      );

  TextStyle get headline2 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 25,
        height: 25 / 25,
      );

  TextStyle get headline3 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        height: 22 / 22,
      );

  TextStyle get headline4 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        height: 22 / 22,
      );

  TextStyle get headline5 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        height: 20 / 18,
      );

  TextStyle get headline6 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        height: 18 / 16,
      );

  /// Copy text styles
  TextStyle get copyTextH4 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 20,
        height: 22 / 20,
      );

  TextStyle get copyTextH5 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 18,
        height: 20 / 18,
      );

  TextStyle get copyTextH6 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 18 / 16,
      );

  TextStyle get copyTextH7 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        height: 15 / 14,
      );

  TextStyle get copyTextH8 => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 13,
        height: 14 / 13,
      );

  /// Price styles
  TextStyle get priceL => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        height: 25 / 30,
      );

  TextStyle get priceM => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 25,
        height: 22 / 25,
      );

  TextStyle get priceS => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        height: 22 / 18,
      );

  TextStyle get priceXS => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        height: 22 / 16,
      );

  TextStyle get priceXSRegular => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 22 / 16,
      );
}
