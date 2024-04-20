import 'package:flutter/material.dart';
import 'package:vmeste/ui/theme/colors.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    shadowColor: AppColors.primaryColor.withOpacity(0.17),
    dividerColor: AppColors.dividerColor,
    hintColor: AppColors.hintColor,
    errorColor: AppColors.errorColor,
    dialogBackgroundColor: Colors.white,
    disabledColor: AppColors.disabledColor,
    buttonTheme: buttonTheme,
    textTheme: textTheme,
    fontFamily: 'Montserrat');

final TextTheme textTheme = TextTheme(
    headline1: const TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    headline2: const TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headline3: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline4: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyText1: const TextStyle(
      color: AppColors.inputColor,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: AppColors.hintColor,
      fontSize: 12,
    ),
    button: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ));

final ButtonThemeData buttonTheme = ButtonThemeData(
  shape: const StadiumBorder(),
  buttonColor: AppColors.primaryColor,
  disabledColor: AppColors.disabledColor,
);
