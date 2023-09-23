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
    }
    return data;
  }
}
