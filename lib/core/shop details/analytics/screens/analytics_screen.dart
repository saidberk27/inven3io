import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final String imageAssetString = 'assets/images/logowhite.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Image.asset(imageAssetString)),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Demo Data")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/report");
                },
                child: Text("Real Data"))
          ],
        )));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
