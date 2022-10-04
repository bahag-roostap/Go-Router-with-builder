import 'package:flutter/material.dart';

class BahagColor {
  static const bauhausRed = Color.fromARGB(255, 238, 31, 38);
  static const bauhausRedInactive = Color.fromARGB(255, 252, 210, 212);
  static const paletteBlue = Color.fromARGB(255, 80, 120, 140);
  static const paletteRed = Color.fromARGB(255, 180, 24, 33);
  static const paletteYellow = Color.fromARGB(255, 170, 129, 64);
  static const paletteGreen = Color.fromARGB(255, 90, 125, 45);
  static const paletteGreenSuccess = Color.fromARGB(255, 59, 167, 0);
  static const palettePurple = Color.fromARGB(255, 150, 70, 150);
  static const nearlyWhite = Color.fromARGB(255, 255, 255, 255);
  static const nearlyWhiteDarker = Color.fromARGB(255, 240, 240, 240);
  static const nearlyBlack = Color.fromARGB(255, 51, 51, 51);
  static const veryNearlyBlack = Color.fromARGB(255, 12, 12, 12);
  static const darkGrey = Color.fromARGB(255, 102, 102, 102);
  static const darkGreyLighter = Color.fromARGB(255, 102, 102, 102);
  static const grey = Color.fromARGB(255, 150, 150, 150);
  static const lightGrey = Color.fromARGB(255, 200, 200, 200);
  static const lighterGrey = Color.fromARGB(255, 216, 216, 216);
  static const registrationGrey = Color.fromARGB(255, 112, 112, 112);
  static const bottomNavBar = Color.fromARGB(255, 245, 245, 245);
  static const mengenVorteilYellow = Color.fromARGB(255, 255, 235, 0);

  static const filterBeige = Color.fromARGB(255, 245, 245, 220);
  static const filterBlue = Color.fromARGB(255, 0, 48, 143);
  static const filterBrown = Color.fromARGB(255, 150, 75, 0);
  static const filterBronze = Color.fromARGB(255, 163, 112, 0);
  static const filterTransparent = Color.fromARGB(255, 0, 0, 0);
  static const filterYellow = Color.fromARGB(255, 255, 255, 0);
  static const filterGold = Color.fromARGB(255, 255, 215, 0);
  static const filterGray = Color.fromARGB(255, 128, 128, 128);
  static const filterGreen = Color.fromARGB(255, 0, 128, 0);
  static const filterMultiColored = Color.fromARGB(255, 0, 0, 0);
  static const filterOrange = Color.fromARGB(255, 255, 123, 0);
  static const filterPink = Color.fromARGB(255, 255, 192, 203);
  static const filterRed = Color.fromARGB(255, 255, 0, 0);
  static const filterBlack = Color.fromARGB(255, 0, 0, 0);
  static const filterSilver = Color.fromARGB(255, 192, 192, 192);
  static const filterViolett = Color.fromARGB(255, 238, 130, 238);
  static const filterWhite = Color.fromARGB(255, 255, 255, 255);
}

extension CustomColorScheme on ColorScheme {
  Color get logo => brightness == Brightness.light ? bauhausRed : bauhausRed;
  Color get headlineTextColor => brightness == Brightness.light
      ? BahagColor.darkGrey
      : BahagColor.nearlyWhite;
  Color get shadow => brightness == Brightness.light
      ? BahagColor.nearlyBlack
      : BahagColor.nearlyWhite;
  Color get border => brightness == Brightness.light
      ? const Color.fromARGB(255, 215, 215, 215)
      : const Color.fromARGB(255, 55, 55, 55);
  Color get bottomTabBarIcon => brightness == Brightness.light
      ? const Color.fromARGB(255, 215, 215, 215)
      : const Color.fromARGB(255, 55, 55, 55);
  Color get bottomTabBarIconActive => brightness == Brightness.light
      ? BahagColor.bauhausRed
      : BahagColor.bauhausRed;
  Color get bauhausRed => brightness == Brightness.light
      ? BahagColor.bauhausRed
      : BahagColor.bauhausRed;
  Color get buttonIconColor => brightness == Brightness.light
      ? BahagColor.nearlyWhite
      : BahagColor.darkGrey;
  Color get checkColor => brightness == Brightness.light
      ? BahagColor.nearlyWhite
      : BahagColor.darkGrey;
  Color get storyTab => checkColor;
  Color get storyTabTextColor => brightness == Brightness.light
      ? BahagColor.darkGrey
      : BahagColor.nearlyWhite;
  Color get storyTabBackground => brightness == Brightness.light
      ? BahagColor.nearlyWhite
      : BahagColor.darkGreyLighter;
  Color get cursorColor => storyTabTextColor;
  Color get backgroundCursorColor => checkColor;
  Color get transparentBlack => onPrimary.withAlpha(152);
  Color get listItemBackground => brightness == Brightness.light
      ? const Color.fromARGB(255, 237, 237, 237)
      : const Color.fromARGB(255, 25, 25, 25);
  Color get backgroundAccent => brightness == Brightness.light
      ? BahagColor.nearlyWhiteDarker
      : BahagColor.darkGrey;
}

extension ProfileColorScheme on ColorScheme {
  Color get appBarForgroundColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  Color get appBarBackgroundColor =>
      brightness == Brightness.light ? bauhausRed : bauhausRed;

  Color get profileMenuFillColor => brightness == Brightness.light
      ? Colors.grey.shade200
      : Colors.grey.shade800;

  Color get profileMenuIconColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
}

const lightColorScheme = ColorScheme.light(
  primary: BahagColor.bauhausRed,
  secondary: BahagColor.darkGrey,
);

const darkColorScheme = ColorScheme.dark(
  primary: BahagColor.bauhausRed,
  secondary: BahagColor.paletteBlue,
);
