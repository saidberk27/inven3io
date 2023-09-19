import 'package:flutter/material.dart';

import '../../core/home/screens/home.dart';
import '../../core/login/screens/login_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/home": (context) => HomeScreen(),
    "/login": (context) => LoginScreen()
  };
}
