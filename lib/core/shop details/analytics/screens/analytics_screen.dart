import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_vm.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_screen.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("All Reports",
                style: MainTheme.themeData.textTheme.displayLarge!
                    .copyWith(color: MainTheme.secondaryColor)),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  CardExample(text: "July"),
                  CardExample(text: "August"),
                  CardExample(text: "September"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  late String text;
  CardExample({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportScreen(month: text)));
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.receipt,
                      size: 36,
                    )),
                Expanded(flex: 1, child: Text(text)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
