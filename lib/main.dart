import 'package:flutter/material.dart';
import 'package:inven3io/core/login/screens/login_screen.dart';
import 'config/themes/main_theme.dart';
// Database Imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MainApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
