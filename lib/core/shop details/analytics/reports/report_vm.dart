import 'package:inven3io/data/firestore.dart';

import 'Report.dart';
import 'demo_data.dart';

class ReportViewModel {
  DemoData demoData = DemoData();
  late Map<String, dynamic> data;
  Map<String, dynamic> getDataOfMonth({required String month}) {
    // Using for exported data
    switch (month) {
      case "July":
        data = demoData.july;
        break;
      case "August":
        data = demoData.august;
        break;
      case "September":
        data = demoData.july;
        break;

      default:
        data = demoData.zero;
        break;
    }
    return data;
  }

  void sendReportToDatabase(
      {required Report report, required String currentMonth}) {
    Firestore db = Firestore();
    db.addDocument(collectionPath: "reports", document: report.toJson());
  }

  Future<Map<String, dynamic>> getReportFields() async {
    Firestore db = Firestore();

    List<Map<String, dynamic>> recentReports =
        await db.readDocumentsOfCollectionByTime(collectionPath: "reports");

    Map<String, dynamic> recentReport = recentReports[0];
    num totalItemsSold = 0;
    num totalRevenue = 0;

    totalItemsSold = (recentReport["kozyatagi"]["ItemsSold"] +
        recentReport["fenerbahce"]["ItemsSold"] +
        recentReport["tesvikiye"]["ItemsSold"]);
    totalRevenue = (recentReport["kozyatagi"]["Revenue"] +
        recentReport["fenerbahce"]["Revenue"] +
        recentReport["tesvikiye"]["Revenue"]);

    Map<String, dynamic> futureDatasOfAnalytics = {
      "TotalItems": totalItemsSold,
      "TotalRevenue": totalRevenue,
      "Fenerbahce": {
        "revenue": recentReport["fenerbahce"]["Revenue"],
        "item": recentReport["fenerbahce"]["ItemsSold"],
        "BestSeller": recentReport["fenerbahce"]["BestSeller"] ?? "None"
      },
      "Tesvikiye": {
        "revenue": recentReport["tesvikiye"]["Revenue"],
        "item": recentReport["tesvikiye"]["ItemsSold"],
        "BestSeller": recentReport["tesvikiye"]["BestSeller"] ?? "None"
      },
      "Kozyatagi": {
        "revenue": recentReport["kozyatagi"]["Revenue"],
        "item": recentReport["kozyatagi"]["ItemsSold"],
        "BestSeller": recentReport["kozyatagi"]["BestSeller"] ?? "None"
      }
    };

    return futureDatasOfAnalytics;
  }
}
