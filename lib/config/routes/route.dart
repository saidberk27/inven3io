import 'package:flutter/material.dart';
import 'package:inven3io/core/shop%20details/analytics/screens/analytics_screen.dart';
import 'package:inven3io/core/shop%20details/inventory/barcode%20scanner/screens/barcode_screen.dart';
import 'package:inven3io/core/shop%20details/inventory/screens/inventory_screen.dart';
import 'package:inven3io/core/shop%20details/screens/shop_details.dart';

import '../../core/home/screens/home.dart';
import '../../core/login/screens/login_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/home": (context) => const HomeScreen(),
    "/login": (context) => const LoginScreen(),
    "/shop": (context) => const ShopDetailsScreen(),
    "/inventory": (context) => const InventoryScreen(),
    "/analytics": (context) => const AnalyticsScreen(),
    "/barcode": (context) => const BarcodeScannerScreen()
  };
}
