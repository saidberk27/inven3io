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

  Future<Map<String, dynamic>> getStats() async {
    Firestore db = Firestore();

    List<Map<String, dynamic>> recentReports =
        await db.readDocumentsOfCollection(collectionPath: "reports");

    Map<String, dynamic> recentReport = recentReports[0];
    num TotalItemsSold = 0;
    num TotalRevenue = 0;
    TotalItemsSold = (recentReport["kozyatagi"]["ItemsSold"] +
        recentReport["fenerbahce"]["ItemsSold"] +
        recentReport["tesvikiye"]["ItemsSold"]);

    TotalRevenue = (recentReport["kozyatagi"]["Revenue"] +
        recentReport["fenerbahce"]["Revenue"] +
        recentReport["tesvikiye"]["Revenue"]);

    Map<String, dynamic> futureDatasOfAnalytics = {
      "TotalItems": TotalItemsSold,
      "TotalRevenue": TotalRevenue,
      "Fenerbahce": {
        "revenue": recentReport["fenerbahce"]["Revenue"],
        "item": recentReport["fenerbahce"]["ItemsSold"]
      },
      "Tesvikiye": {
        "revenue": recentReport["tesvikiye"]["Revenue"],
        "item": recentReport["tesvikiye"]["ItemsSold"]
      },
      "Kozyatagi": {
        "revenue": recentReport["kozyatagi"]["Revenue"],
        "item": recentReport["kozyatagi"]["ItemsSold"]
      }
    };

    return futureDatasOfAnalytics;
  }
}
