import 'package:flutter/material.dart';

class AppColors {
  static final Color backgroundColor = HexColor('#FCFCFC');
  static final Color primaryColor = HexColor('#FCFCFC');
  static final Color dividerColor = HexColor('#E5E5E5');
  static final Color hintColor = HexColor('#9B9DA1');
  static final Color errorColor = HexColor('#D32F2F');
  static final Color disabledColor = HexColor('#61000000');
  static final Color shadowColor = primaryColor.withOpacity(0.25);
  static final Color inputFillColor = HexColor('#EDF2F6');
  static const Color blackColor = Colors.black;
  static final Color borderColor = HexColor('#B5BFE8');
  static final Color purple = HexColor('#CABAFF');
  static final Color darkPurple = HexColor('#7121EF');
  static final Color green = HexColor('#D2F634');
  static final Color white = HexColor('#FFFFFF');
  static final Color black = HexColor('#000000');
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
