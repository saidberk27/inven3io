import 'package:flutter/material.dart';
import 'package:inven3io/core/shop%20details/analytics/reports/report_vm.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/themes/main_theme.dart';

class ReportScreen extends StatefulWidget {
  late String month;
  ReportScreen({super.key, required this.month});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late List<ChartDataGeneral> dataItemsSold;
  late List<ChartDataGeneral> dataRevenue;

  late List<ChartDataPie> dataItemsSoldPie;
  late List<ChartDataPie> dataRevenuePie;

  late Map<String, dynamic> bestSeller;

  late double totalItemsSold;
  late double totalRevenue;

  late ReportViewModel reportViewModel;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    super.initState();
    reportViewModel = ReportViewModel();

    Map<String, dynamic> monthData =
        reportViewModel.getDataOfMonth(month: widget.month);

    totalItemsSold = monthData['total']['items'].toDouble();
    totalRevenue = monthData['total']['revenue'].toDouble();

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
            child: FutureBuilder(
              future: reportViewModel.getReportFields(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? data = snapshot.data;

                  // In Future Builder Data Initilazations
                  dataItemsSold = [
                    ChartDataGeneral(
                        'TEŞVİKİYE', data!['Tesvikiye']['item'].toDouble()),
                    ChartDataGeneral(
                        'FENERBAHÇE', data['Fenerbahce']['item'].toDouble()),
                    ChartDataGeneral(
                        'KOZYATAĞI', data['Kozyatagi']['item'].toDouble()),
                  ];

                  dataRevenue = [
                    ChartDataGeneral(
                        'TEŞVİKİYE', data['Tesvikiye']['revenue'].toDouble()),
                    ChartDataGeneral(
                        'FENERBAHÇE', data['Fenerbahce']['revenue'].toDouble()),
                    ChartDataGeneral(
                        'KOZYATAĞI', data['Kozyatagi']['revenue'].toDouble()),
                  ];

                  dataItemsSoldPie = [
                    ChartDataPie(
                        'TEŞVİKİYE',
                        data['Tesvikiye']['item'].toDouble(),
                        MainTheme.secondaryColor),
                    ChartDataPie(
                        'FENERBAHÇE',
                        data['Fenerbahce']['item'].toDouble(),
                        MainTheme.fifthColor),
                    ChartDataPie(
                        'KOZYATAĞI',
                        data['Kozyatagi']['item'].toDouble(),
                        MainTheme.fourthColor),
                  ];

                  dataRevenuePie = [
                    ChartDataPie(
                        'TEŞVİKİYE',
                        data['Tesvikiye']['revenue'].toDouble(),
                        MainTheme.secondaryColor),
                    ChartDataPie(
                        'FENERBAHÇE',
                        data['Fenerbahce']['revenue'].toDouble(),
                        MainTheme.fifthColor),
                    ChartDataPie(
                        'KOZYATAĞI',
                        data['Kozyatagi']['revenue'].toDouble(),
                        MainTheme.fourthColor),
                  ];
                  bestSeller = {
                    "Tesvikiye": data['Tesvikiye']['BestSeller'],
                    "Fenerbahce": data['Fenerbahce']['BestSeller'],
                    "Kozyatagi": data['Kozyatagi']['BestSeller']
                  };

                  //In Future Builder Data Initilazations
                  return Column(
                    children: [
                      Text(
                        "2023 ${widget.month} Report",
                        textAlign: TextAlign.center,
                        style: MainTheme.themeData.textTheme.displayLarge!
                            .copyWith(color: MainTheme.secondaryColor),
                      ),
                      const SizedBox(height: 20),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          _buildTableRow('Total Number Of Items Sold',
                              '${data['TotalItems']}'),
                          _buildTableRow(
                              'Total Revenue', '${data['TotalRevenue']}'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ColumnChart(
                        tooltip: _tooltip,
                        dataItemsSold: dataItemsSold,
                        dataRevenue: dataRevenue,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Text("Products Sold",
                              style: MainTheme
                                  .themeData.textTheme.displayMedium!
                                  .copyWith(color: MainTheme.secondaryColor)),
                          PieChart(dataMap: dataItemsSoldPie),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Text("Products Revenue",
                              style: MainTheme
                                  .themeData.textTheme.displayMedium!
                                  .copyWith(color: MainTheme.secondaryColor)),
                          PieChart(dataMap: dataRevenuePie, isDoughnut: true),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Text("Reccomended Product",
                              style: MainTheme
                                  .themeData.textTheme.displayMedium!
                                  .copyWith(color: MainTheme.secondaryColor)),
                          const SizedBox(height: 10),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              _buildTableRow(
                                  'Teşvikiye', bestSeller['Tesvikiye']!),
                              _buildTableRow(
                                  'Fenerbahçe', bestSeller['Fenerbahce']!),
                              _buildTableRow(
                                  'Kozyatağı', bestSeller['Kozyatagi']!)
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                          color: MainTheme.secondaryColor));
                }
              },
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
                const Text("KOZYATAĞI")
              ],
            ),
            Row(
              children: [
                Icon(Icons.rectangle, color: MainTheme.fifthColor),
                const Text("FENERBAHÇE")
              ],
            ),
            Row(
              children: [
                Icon(Icons.rectangle, color: MainTheme.secondaryColor),
                const Text("TEŞVİKİYE")
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
            minimum: 0, maximum: 100, interval: 10, labelStyle: labelStyle),
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
      height: 50,
      color: backgroundColor,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
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
