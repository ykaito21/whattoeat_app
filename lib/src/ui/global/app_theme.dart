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
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(
      color: Colors.grey[50],
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorList.primaryOrange,
    ),
  ),
  AppTheme.Dark: ThemeData.dark().copyWith(
    primaryColor: ColorList.primaryBlue,
    accentColor: ColorList.primaryCream,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorList.primaryCream,
    ),
  ),
};
