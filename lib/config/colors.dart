import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';


class GlobalColors {
  static const Color primaryColor = Color.fromARGB(255, 2, 0, 36);
  static const Color colorGradientSecondary = Color.fromARGB(255, 6, 5, 82);
  static const Color secondaryColor = Color.fromARGB(255, 9, 9, 121);
  static const Color thirdColor = Color.fromARGB(255, 0, 212, 255);
  static const Color servicesButtons = Colors.white;
  static const Color servicesButtonsText = Colors.black;
  static const Color buttonPrimaryColor = Color.fromARGB(255, 89, 76, 239);
  static const Color backGroundBaseScreenColor = Color.fromARGB(
      255, 201, 229, 235);
}

ThemeData kappLightTheme = FlexThemeData.light(
  scheme: FlexScheme.aquaBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment

);

ThemeData kappDarkTheme =  FlexThemeData.dark(
  scheme: FlexScheme.aquaBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    useInputDecoratorThemeInDialogs: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);



