import 'package:flutter/material.dart';

class MainTheme {
  static Color primaryColor = const Color(0xFFF9C18E);
  static Color secondaryColor = const Color(0XFFE07C20);
  static Color thirdColor = Colors.white;

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        background: Colors.red),
    scaffoldBackgroundColor: primaryColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'MainFont'),
      displayMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'MainFont'),
      displaySmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'MainFont'),
      bodyLarge: TextStyle(fontSize: 16, fontFamily: 'MainFont'),
      bodyMedium: TextStyle(fontSize: 14, fontFamily: 'MainFont'),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: secondaryColor, // App bar background color
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: thirdColor, // Text color of the app bar title
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: secondaryColor, // Default button color
      textTheme: ButtonTextTheme.primary, // Text color for buttons
    ),
  );
}
