import 'package:flutter/material.dart';

class AppColors {
  /// AppColors
  static const Color primaryWhiteColor = Color(0xffFFFFFF);
  static const Color primaryBlueColor = Color(0xff1DA1F2);
  static const Color greyColor = Color(0xffE5E5E5);
  static const Color greyShade = Color(0xff949C9E);
  static const Color primaryBlackColor = Color(0xff323238);
  static const Color lightBlueColor = Color(0xffEDF8FF);
  static const Color scaffoldColor = Color(0xffF2F2F2);
  static const Color redColor = Color(0xffF34642);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
