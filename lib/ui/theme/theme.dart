// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:VMeste/ui/theme/colors.dart';

final ThemeData lightTheme = ThemeData(
    backgroundColor: AppColors.backgroundColor,
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
    fontFamily: 'VelaSans');

TextTheme textTheme = TextTheme(
    headline1: const TextStyle(
      fontFamily: 'VelaSans',
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    headline2: const TextStyle(
      fontFamily: 'VelaSans',
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headline3: const TextStyle(
      fontFamily: 'VelaSans',
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyText1: const TextStyle(
      color: AppColors.blackColor,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: AppColors.hintColor,
      fontSize: 12,
    ));

final ButtonThemeData buttonTheme = ButtonThemeData(
  shape: const StadiumBorder(),
  buttonColor: AppColors.primaryColor,
  disabledColor: AppColors.disabledColor,
);
