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

const TextTheme textTheme = TextTheme(
    headline1: TextStyle(
      fontFamily: 'VelaSans',
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    bodyText1: TextStyle(
      color: AppColors.blackColor,
      fontSize: 16,
    ));

final ButtonThemeData buttonTheme = ButtonThemeData(
  shape: const StadiumBorder(),
  buttonColor: AppColors.primaryColor,
  disabledColor: AppColors.disabledColor,
);
