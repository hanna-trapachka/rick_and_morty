import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

sealed class AppTheme {
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    textTheme: _textTheme,
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    textTheme: _textTheme,
  );
}

const TextTheme _textTheme = TextTheme(
  bodySmall: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.28,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.25,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 1.22,
  ),
  labelSmall: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.25,
  ),
  labelMedium: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.33,
  ),
  labelLarge: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.25,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.25,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 28,
    height: 1.28,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.125,
    letterSpacing: -.1,
  ),
  displaySmall: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 56,
    height: 1,
  ),
  displayMedium: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 64,
    height: 1,
  ),
  displayLarge: TextStyle(
    fontFamily: 'TT-Commons',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 72,
    height: 1.05556,
    letterSpacing: -.1,
  ),
);
