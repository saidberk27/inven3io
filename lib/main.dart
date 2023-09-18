import 'package:flutter/material.dart';
import 'package:inven3io/core/login/screens/login_screen.dart';
import 'config/themes/main_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainTheme.themeData,
      home: const LoginScreen(),
    );
  }
}
