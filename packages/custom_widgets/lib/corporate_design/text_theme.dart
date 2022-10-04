import 'package:flutter/material.dart';

import 'color.dart';

extension CustomLightTextTheme on TextTheme {
  TextStyle get buttonTextLight => const TextStyle(
        fontSize: 14,
        color: BahagColor.nearlyWhite,
        decoration: TextDecoration.none,
      );
  TextStyle get buttonTextDark => const TextStyle(
        fontSize: 14,
        color: BahagColor.darkGrey,
        decoration: TextDecoration.none,
      );
  TextStyle get bodyTextBold => const TextStyle(fontWeight: FontWeight.bold);
  TextStyle get headline5Bold =>
      headline5!.copyWith(fontWeight: FontWeight.bold);

  TextStyle get priceLargeStyle => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: BahagColor.darkGrey,
      );
  TextStyle get priceMediumStyle => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: BahagColor.darkGrey,
      );
  TextStyle get priceSmallStyle => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: BahagColor.darkGrey,
      );

  TextStyle get underlined => const TextStyle(
        color: Colors.black,
        fontFamily: 'Taz',
        fontWeight: FontWeight.normal,
        fontSize: 16,
        decoration: TextDecoration.underline,
      );
  TextStyle get bodyText1Black => const TextStyle(
        color: Colors.black,
        fontFamily: 'Taz',
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 1.125,
      );
  TextStyle get productTileProductName => const TextStyle(
        color: BahagColor.darkGrey,
        fontFamily: 'Taz',
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
}

const textThemeLight = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      height: 1.16,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    headline2: TextStyle(
      fontSize: 25,
      height: 1.0,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    headline3: TextStyle(
      fontSize: 22,
      height: 1.0,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    headline4: TextStyle(
      fontSize: 20,
      height: 1.1,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    headline5: TextStyle(
      fontSize: 18,
      height: 1.11,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    headline6: TextStyle(
      fontSize: 16,
      height: 1.125,
      fontWeight: FontWeight.bold,
      color: BahagColor.darkGrey,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.125,
      fontWeight: FontWeight.normal,
      color: BahagColor.darkGrey,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      height: 1.07,
      fontWeight: FontWeight.normal,
      color: BahagColor.darkGrey,
    ),
    button: TextStyle(
      fontSize: 22,
      height: 1.13,
      fontWeight: FontWeight.bold,
      color: BahagColor.nearlyWhite,
    ),
    caption: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: BahagColor.darkGrey,
    ));
const textThemeDark = TextTheme();
const fontFamily = 'Taz';
