import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_generator.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_screen.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_vm.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_screen_demo.dart';
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
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible:
                  false, // Prevent closing the dialog by tapping outside
              builder: (BuildContext context) {
                // You can use a CircularProgressIndicator or any other widget here
                return Dialog(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(), // Replace with your loading indicator
                        SizedBox(height: 16.0),
                        Text("Your report is generating... Please Wait"),
                      ],
                    ),
                  ),
                );
              },
            );

            ReportGenerator().generateReport().then((report) {
              // TODO bu value'yi fireabse'ye at. September raporu için firebase'den verileri al. Bestselleri eklemeyi unutma.

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Report Succesfully Generated and Updated. Check Current Month's Report From  Analytics Screen")));
              Navigator.of(context).pop();
            });
          },
          label: Text("Generate Report")),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 64),
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
                  CardExample(text: "September", isDemo: false),
                  CardExample(text: "October"),
                  CardExample(text: "November"),
                  CardExample(text: "December"),
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
  bool isDemo;
  CardExample({
    super.key,
    required this.text,
    this.isDemo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            if (isDemo) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportScreenDemo(month: text)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportScreen(month: text)));
            }
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
