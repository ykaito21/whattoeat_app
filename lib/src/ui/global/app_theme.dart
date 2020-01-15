import 'package:flutter/material.dart';
import '../global/color_list.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemes = {
  AppTheme.Light: ThemeData().copyWith(
    primaryColor: ColorList.primaryCream,
    accentColor: ColorList.primaryOrange,
    scaffoldBackgroundColor: ColorList.primaryCream,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: ColorList.primaryOrange,
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorList.primaryOrange,
      ),
      elevation: 0,
    ),
  ),
  AppTheme.Dark: ThemeData.dark().copyWith(
    primaryColor: ColorList.primaryBlue,
    accentColor: ColorList.primaryCream,
    scaffoldBackgroundColor: ColorList.primaryBlue,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: ColorList.primaryCream,
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorList.primaryCream,
      ),
      elevation: 0,
    ),
  ),
};
