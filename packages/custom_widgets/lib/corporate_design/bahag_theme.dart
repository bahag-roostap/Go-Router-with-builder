import 'package:flutter/material.dart';

import 'color.dart';
import 'input_decoration_themes.dart';
import 'text_theme.dart';

class BahagTheme {
  BahagTheme._();
  static final ThemeData light = ThemeData(
    fontFamily: fontFamily,
    colorScheme: lightColorScheme,
    textTheme: textThemeLight,
    extensions: <ThemeExtension<dynamic>>[
      InputDecorationThemes.light,
    ],
  );

  static final ThemeData dark = ThemeData(
    fontFamily: fontFamily,
    colorScheme: darkColorScheme,
    textTheme: textThemeDark,
    extensions: <ThemeExtension<dynamic>>[
      InputDecorationThemes.dark,
    ],
  );
}
