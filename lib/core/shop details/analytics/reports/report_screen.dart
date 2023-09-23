import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/themes/main_theme.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late List<ChartDataGeneral> dataItemsSold;
  late List<ChartDataGeneral> dataRevenue;

  late List<ChartDataPie> dataItemsSoldPie;
  late List<ChartDataPie> dataRevenuePie;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataItemsSold = [
      ChartDataGeneral('TEŞVİKİYE', 20),
      ChartDataGeneral('FENERBAHÇE', 40),
      ChartDataGeneral('KOZYATAĞI', 90),
    ];

    dataRevenue = [
      ChartDataGeneral('TEŞVİKİYE', 20 * 6),
      ChartDataGeneral('FENERBAHÇE', 40 * 6),
      ChartDataGeneral('KOZYATAĞI', 90 * 6),
    ];

    dataItemsSoldPie = [
      ChartDataPie('TEŞVİKİYE', 20, MainTheme.secondaryColor),
      ChartDataPie('FENERBAHÇE', 40, MainTheme.fifthColor),
      ChartDataPie('KOZYATAĞI', 90, MainTheme.fourthColor),
    ];

    dataRevenuePie = [
      ChartDataPie('TEŞVİKİYE', 20 * 6, MainTheme.secondaryColor),
      ChartDataPie('FENERBAHÇE', 40 * 6, MainTheme.fifthColor),
      ChartDataPie('KOZYATAĞI', 90 * 6, MainTheme.fourthColor),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  final String imageAssetString = 'assets/images/logowhite.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Image.asset(imageAssetString)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "2023 August Report",
                  textAlign: TextAlign.center,
                  style: MainTheme.themeData.textTheme.displayLarge!
                      .copyWith(color: MainTheme.secondaryColor),
                ),
                SizedBox(height: 20),
                Table(
                  children: [
                    _buildTableRow('Total Number Of Items Sold', '90'),
                    _buildTableRow('Total Revenue', '360'),
                    _buildTableRow('Increase From Last Month', '%4.9'),
                  ],
                ),
                SizedBox(height: 20),
                ColumnChart(
                  tooltip: _tooltip,
                  dataItemsSold: dataItemsSold,
                  dataRevenue: dataRevenue,
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text("Products Sold",
                        style: MainTheme.themeData.textTheme.displayMedium!
                            .copyWith(color: MainTheme.secondaryColor)),
                    PieChart(dataMap: dataItemsSoldPie),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text("Products Revenue",
                        style: MainTheme.themeData.textTheme.displayMedium!
                            .copyWith(color: MainTheme.secondaryColor)),
                    PieChart(dataMap: dataRevenuePie, isDoughnut: true),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class PieChart extends StatelessWidget {
  PieChart({super.key, required this.dataMap, this.isDoughnut = false});

  final List<ChartDataPie> dataMap;
  final TextStyle labelStyle = MainTheme.themeData.textTheme.displaySmall!;
  final bool isDoughnut;

  @override
  Widget build(BuildContext context) {
    CircularSeries series;
    if (!isDoughnut) {
      series = PieSeries<ChartDataPie, String>(
          dataSource: dataMap,
          pointColorMapper: (ChartDataPie data, _) => data.color,
          explode: true,
          explodeAll: true,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: MainTheme.themeData.textTheme.displaySmall!
                  .copyWith(color: Colors.white)),
          xValueMapper: (ChartDataPie data, _) => data.x,
          yValueMapper: (ChartDataPie data, _) => data.y);
    } else {
      series = DoughnutSeries<ChartDataPie, String>(
          dataSource: dataMap,
          pointColorMapper: (ChartDataPie data, _) => data.color,
          explode: true,
          explodeAll: true,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: MainTheme.themeData.textTheme.displaySmall!
                  .copyWith(color: Colors.white)),
          xValueMapper: (ChartDataPie data, _) => data.x,
          yValueMapper: (ChartDataPie data, _) => data.y);
    }
    return Column(
      children: [
        SfCircularChart(series: <CircularSeries>[series]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.rectangle, color: MainTheme.fourthColor),
                Text("KOZYATAĞI")
              ],
            ),
            Row(
              children: [
                Icon(Icons.rectangle, color: MainTheme.fifthColor),
                Text("FENERBAHÇE")
              ],
            ),
            Row(
              children: [
                Icon(Icons.rectangle, color: MainTheme.secondaryColor),
                Text("TEŞVİKİYE")
              ],
            )
          ],
        )
      ],
    );
  }
}

class ColumnChart extends StatelessWidget {
  ColumnChart({
    super.key,
    required TooltipBehavior tooltip,
    required this.dataItemsSold,
    required this.dataRevenue,
  }) : _tooltip = tooltip;

  final TooltipBehavior _tooltip;
  final List<ChartDataGeneral> dataItemsSold;
  final List<ChartDataGeneral> dataRevenue;
  final TextStyle labelStyle = MainTheme.themeData.textTheme.displaySmall!
      .copyWith(fontSize: 18, color: MainTheme.fifthColor);
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(labelStyle: labelStyle),
        primaryYAxis: NumericAxis(
            minimum: 0, maximum: 600, interval: 20, labelStyle: labelStyle),
        tooltipBehavior: _tooltip,
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: labelStyle.copyWith(color: Colors.grey.shade800)),
        series: <ChartSeries<ChartDataGeneral, String>>[
          ColumnSeries<ChartDataGeneral, String>(
              dataSource: dataItemsSold,
              xValueMapper: (ChartDataGeneral data, _) => data.x,
              yValueMapper: (ChartDataGeneral data, _) => data.y,
              name: 'Items Sold',
              color: MainTheme.secondaryColor),
          ColumnSeries<ChartDataGeneral, String>(
              dataSource: dataRevenue,
              xValueMapper: (ChartDataGeneral data, _) => data.x,
              yValueMapper: (ChartDataGeneral data, _) => data.y,
              name: 'Revenue',
              color: MainTheme.fourthColor)
        ]);
  }
}

TableRow _buildTableRow(String header, String content) {
  return TableRow(
    children: [
      _buildTableCell(header, MainTheme.fourthColor, Colors.white),
      _buildTableCell(content, MainTheme.fifthColor, Colors.black),
    ],
  );
}

TableCell _buildTableCell(String text, Color backgroundColor, Color textColor) {
  return TableCell(
    child: Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

class ChartDataGeneral {
  ChartDataGeneral(
    this.x,
    this.y,
  );
  final String x;
  final double y;
}

class ChartDataPie {
  ChartDataPie(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
