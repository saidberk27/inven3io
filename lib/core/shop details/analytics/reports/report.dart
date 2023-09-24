import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  late int month;
  late Map<String, dynamic> tesvikiye;
  late Map<String, dynamic> fenerbahce;
  late Map<String, dynamic> kozyatagi;
  late Timestamp timeStamp;

  // Constructor to initialize the class properties
  Report({
    required this.month,
    required this.tesvikiye,
    required this.fenerbahce,
    required this.kozyatagi,
    required this.timeStamp,
  });

  // Convert the Report object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'tesvikiye': tesvikiye,
      'fenerbahce': fenerbahce,
      'kozyatagi': kozyatagi,
      'timeStamp': timeStamp
    };
  }

  // Create a Report object from a JSON Map
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      month: json['month'] as int,
      tesvikiye: json['tesvikiye'] as Map<String, dynamic>,
      fenerbahce: json['fenerbahce'] as Map<String, dynamic>,
      kozyatagi: json['kozyatagi'] as Map<String, dynamic>,
      timeStamp: json['timeStamp'] as Timestamp,
    );
  }
}
