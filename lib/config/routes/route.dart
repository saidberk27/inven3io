import 'package:flutter/material.dart';
import 'package:inven3io/core/shop%20details/screens/shop_details.dart';

import '../../core/home/screens/home.dart';
import '../../core/login/screens/login_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/home": (context) => const HomeScreen(),
    "/login": (context) => const LoginScreen(),
    '/shop': (context) => ShopDetailsScreen(),
  };
}
