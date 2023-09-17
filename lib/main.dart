import 'package:flutter/material.dart';
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
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () => {}),
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Hello World!',
            style: MainTheme.themeData.textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
