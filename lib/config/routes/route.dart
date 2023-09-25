import 'package:flutter/material.dart';
import 'package:inven3io/core/login/screens/signup_screen.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_screen.dart';
import 'package:inven3io/core/shop%20details/analytics/screens/analytics_screen.dart';
import 'package:inven3io/core/shop%20details/inventory/add%20product/add_product_form.dart';

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
    "/addProductForm": (context) => const AddProductForm(),
    "/report": (context) => ReportScreen(month: "config",),
    "/signUp": (context) => SignUpScreen(),
  };
}
