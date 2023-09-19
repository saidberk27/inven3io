import 'package:flutter/material.dart';

class MainTheme {
  static const Color _primaryColor = Color(0xFFF9C18E);
  static const Color _secondaryColor = Color(0XFFE07C20);
  static const Color _thirdColor = Colors.white;
  static const Color _fourthColor = Color(0XFFFC8A21);

  static Color get primaryColor => _primaryColor;
  static Color get secondaryColor => _secondaryColor;
  static Color get thirdColor => _thirdColor;
  static Color get fourthColor => _fourthColor;

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: _primaryColor,
        secondary: _secondaryColor,
        background: Colors.red),
    scaffoldBackgroundColor: _primaryColor,
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
    appBarTheme: const AppBarTheme(
      backgroundColor: _secondaryColor, // App bar background color
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: _thirdColor, // Text color of the app bar title
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _secondaryColor, // Default button color
      textTheme: ButtonTextTheme.primary, // Text color for buttons
    ),
  );
}
