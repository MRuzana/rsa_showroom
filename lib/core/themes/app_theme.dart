import 'package:flutter/material.dart';

class AppTheme{

  // light theme

  static final ThemeData appTheme = ThemeData(
   // brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF0000)),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // Ensures white AppBar
    foregroundColor: Colors.black, // Ensures black text/icons
    elevation: 0, // Removes shadow
  ),
  );

  // // Dark Theme
  // static final ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF0000), brightness: Brightness.dark),
  //   useMaterial3: true,
  // );
}