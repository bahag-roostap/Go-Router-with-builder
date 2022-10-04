import 'package:custom_widgets/corporate_design/theme.dart';
import 'package:flutter/material.dart';

class InputDecorationThemes extends ThemeExtension<InputDecorationThemes> {
  const InputDecorationThemes({
    required this.formInputDecorationTheme,
  });
  final InputDecorationTheme formInputDecorationTheme;
  @override
  InputDecorationThemes copyWith({
    InputDecorationTheme? formInputDecorationTheme,
  }) {
    return InputDecorationThemes(
      formInputDecorationTheme:
          formInputDecorationTheme ?? this.formInputDecorationTheme,
    );
  }

  // Controls how the properties change on theme changes
  @override
  InputDecorationThemes lerp(
      ThemeExtension<InputDecorationThemes>? other, double t) {
    return this;
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'InputDecorations('
      'formInputDecorationTheme: $formInputDecorationTheme'
      ')';

  static const _greyBoarderSide = BorderSide(
    color: BahagColor.registrationGrey,
  );

  static const _yellowBoarderSide = BorderSide(
    color: BahagColor.paletteYellow,
  );

  static const InputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.zero,
  );

  // the light theme
  static final light = InputDecorationThemes(
    formInputDecorationTheme: InputDecorationTheme(
      hintStyle: textThemeLight.bodyMedium?.copyWith(
        fontSize: 16,
        color: BahagColor.registrationGrey,
      ),
      labelStyle: textThemeLight.bodyMedium?.copyWith(
        fontSize: 13,
        color: BahagColor.registrationGrey,
      ),
      errorStyle: textThemeLight.caption?.copyWith(
        color: BahagColor.paletteYellow,
      ),
      enabledBorder: _border.copyWith(borderSide: _greyBoarderSide),
      focusedBorder: _border.copyWith(borderSide: _greyBoarderSide),
      errorBorder: _border.copyWith(borderSide: _yellowBoarderSide),
      focusedErrorBorder: _border.copyWith(borderSide: _yellowBoarderSide),
    ),
  );
  // the dark theme
  static final dark = InputDecorationThemes(
    formInputDecorationTheme: InputDecorationTheme(
      hintStyle: textThemeLight.bodyMedium?.copyWith(
        fontSize: 16,
        color: BahagColor.registrationGrey,
      ),
      labelStyle: textThemeLight.bodyMedium?.copyWith(
        fontSize: 13,
        color: BahagColor.registrationGrey,
      ),
      errorStyle: textThemeLight.caption?.copyWith(
        color: BahagColor.paletteYellow,
      ),
      enabledBorder: _border.copyWith(borderSide: _greyBoarderSide),
      focusedBorder: _border.copyWith(borderSide: _greyBoarderSide),
      errorBorder: _border.copyWith(borderSide: _yellowBoarderSide),
      focusedErrorBorder: _border.copyWith(borderSide: _yellowBoarderSide),
    ),
  );
}
