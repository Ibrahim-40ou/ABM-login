import 'package:abm_login/core/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: MyColors.backgroundLight,
    primary: MyColors.primaryLight,
    onPrimary: Colors.white,
    secondary: MyColors.secondaryLight,
    onSecondary: Colors.white,
    error: MyColors.error,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: MyColors.textLight,
    ),
    labelMedium: TextStyle(
      color: MyColors.greyLight,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: MyColors.primaryLight,
    ),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.dark,
    surface: MyColors.backgroundDark,
    primary: MyColors.primaryDark,
    onPrimary: Colors.white,
    secondary: MyColors.secondaryDark,
    onSecondary: Colors.white,
    error: MyColors.error,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: MyColors.textDark,
    ),
    labelMedium: TextStyle(
      color: MyColors.greyDark,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: MyColors.primaryDark,
    ),
  ),
);
