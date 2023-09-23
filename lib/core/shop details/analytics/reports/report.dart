import 'package:inven3io/core/shop%20details/analytics/reports/demo_data.dart';

import 'report_screen.dart';

class Report {
  late String month;

  late List<ChartDataGeneral> dataItemsSold;

  late DemoData demoData;

  Report({
    required this.month,
  }) {
    demoData = DemoData();
  }

  List<ChartDataGeneral> createChartData() {
    switch (month) {
      case "june":
        Map<String, dynamic>? tesvikiyeData = demoData.june["tesvikiye"];
        Map<String, dynamic>? fenerbahceData = demoData.june["fenerbahce"];
        Map<String, dynamic>? kozyatagiData = demoData.june["kozyatagi"];
        dataItemsSold = [
          ChartDataGeneral(
              tesvikiyeData["shopName"], tesvikiyeData["shopSold"]),
          ChartDataGeneral(
              fenerbahceData["shopName"], fenerbahceData["shopSold"]),
          ChartDataGeneral(
              kozyatagiData["shopName"], kozyatagiData["shopSold"]),
        ];
        break;

      case "july":
        Map<String, dynamic>? tesvikiyeData = demoData.july["tesvikiye"];
        Map<String, dynamic>? fenerbahceData = demoData.july["fenerbahce"];
        Map<String, dynamic>? kozyatagiData = demoData.july["kozyatagi"];
        dataItemsSold = [
          ChartDataGeneral(
              tesvikiyeData["shopName"], tesvikiyeData["shopSold"]),
          ChartDataGeneral(
              fenerbahceData["shopName"], fenerbahceData["shopSold"]),
          ChartDataGeneral(
              kozyatagiData["shopName"], kozyatagiData["shopSold"]),
        ];
        break;

      case "august":
        Map<String, dynamic>? tesvikiyeData = demoData.august["tesvikiye"];
        Map<String, dynamic>? fenerbahceData = demoData.august["fenerbahce"];
        Map<String, dynamic>? kozyatagiData = demoData.august["kozyatagi"];
        dataItemsSold = [
          ChartDataGeneral(
              tesvikiyeData["shopName"], tesvikiyeData["shopSold"]),
          ChartDataGeneral(
              fenerbahceData["shopName"], fenerbahceData["shopSold"]),
          ChartDataGeneral(
              kozyatagiData["shopName"], kozyatagiData["shopSold"]),
        ];
    }

    return dataItemsSold;
  }
}
