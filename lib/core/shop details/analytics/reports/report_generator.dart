import 'package:cloud_firestore/cloud_firestore.dart';

class ReportGenerator {
  Future<Map<String, Map<String, Object>>> generateReport() async {
    int currentMonth = detectCurrentMonth();
    Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        documentsOfMonth = await fetchDocumentsInMonth(month: currentMonth);

    return {
      "Fenerbahce": {
        "Revenue": getTotalNumberOfRevenues(
            documents: documentsOfMonth['Fenerbahce']!),
        "ItemsSold": await getTotalNumberOfItemsSold(shopName: "Fenerbahce")
      },
      "Tesvikiye": {
        "Revenue":
            getTotalNumberOfRevenues(documents: documentsOfMonth['Tesvikiye']!),
        "ItemsSold": await getTotalNumberOfItemsSold(shopName: "Tesvikiye")
      },
      "Kozyatagi": {
        "Revenue":
            getTotalNumberOfRevenues(documents: documentsOfMonth['Kozyatagi']!),
        "ItemsSold": await getTotalNumberOfItemsSold(shopName: "Kozyatagi")
      },
    };
  }

  int detectCurrentMonth() => DateTime.now().month;

  Future<Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
      fetchDocumentsInMonth({required int month}) async {
    final firestore = FirebaseFirestore.instance;

    final collection = firestore.collection('logs/');

    final startOfMonth = Timestamp.fromDate(DateTime(2023, month, 1));
    final endOfMonth =
        Timestamp.fromDate(DateTime(2023, month, 30, 23, 59, 59));

    final tesvikiyeSellProductsQuery = collection
        .where('procces', isEqualTo: "SELL") //Fetch only sells.
        .where('shopName', isEqualTo: "Teşvikiye")
        .where('timeStamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timeStamp', isLessThanOrEqualTo: endOfMonth);

    final fenerbahceSellProductsQuery = collection
        .where('procces', isEqualTo: "SELL") //Fetch only sells.
        .where('shopName', isEqualTo: "Fenerbahce")
        .where('timeStamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timeStamp', isLessThanOrEqualTo: endOfMonth);

    final kozyatagiSellProductsQuery = collection
        .where('procces', isEqualTo: "SELL") //Fetch only sells.
        .where('shopName', isEqualTo: "Kozyatağı")
        .where('timeStamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('timeStamp', isLessThanOrEqualTo: endOfMonth);

    final querySnapshotTesvikiye = await tesvikiyeSellProductsQuery.get();
    final tesvikiyeSellProducts = querySnapshotTesvikiye.docs;

    final querySnapshotFenerbahce = await fenerbahceSellProductsQuery.get();
    final fenerbahceSellProducts = querySnapshotFenerbahce.docs;

    final querySnapshotKozyatagi = await kozyatagiSellProductsQuery.get();
    final kozyatagiSellProducts = querySnapshotKozyatagi.docs;

    return {
      "Tesvikiye": tesvikiyeSellProducts,
      "Fenerbahce": fenerbahceSellProducts,
      "Kozyatagi": kozyatagiSellProducts
    };
  }

  Future<num> getTotalNumberOfItemsSold({required String shopName}) async {
    Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        documentsOfMonth =
        await fetchDocumentsInMonth(month: detectCurrentMonth());

    final productQuantityMap =
        getProductQuantityMap(documents: documentsOfMonth[shopName]!);
    return getTotalNumberOfSells(productQuantityMap: productQuantityMap);
  }

  Map<String, dynamic> getProductQuantityMap(
      {required List<QueryDocumentSnapshot<Map<String, dynamic>>> documents}) {
    Map<String, dynamic> productQuantityMap = {};
    Set<String> productVariants = findProductNames(
        documents:
            documents); // This will return the product name once no matter how many of them in records.
    List<String> productNames = [];
    for (final doc in documents) {
      productNames.add(doc[
          "productName"]); // this will add entire products. Same named products can be added multiple times. (Original number of products)
    }
    for (final variant in productVariants) {
      int count = productNames.where((element) => element == variant).length;
      productQuantityMap.addAll({variant: count});
    }

    return productQuantityMap;
  }

  Set<String> findProductNames(
      {required List<QueryDocumentSnapshot<Map<String, dynamic>>> documents}) {
    Set<String> names = Set<String>(); // Using the constructor
    for (final doc in documents) {
      names.add(doc['productName']);
    }
    return names;
  }

  num getTotalNumberOfSells(
      {required Map<String, dynamic> productQuantityMap}) {
    num totalCount = 0;

    for (final productCount in productQuantityMap.values) {
      totalCount = totalCount + productCount;
    }

    return totalCount;
  }

  num getTotalNumberOfRevenues(
      {required List<QueryDocumentSnapshot<Map<String, dynamic>>> documents}) {
    num totalRevenue = 0;
    for (final doc in documents) {
      totalRevenue = totalRevenue + doc["sellPrice"];
    }

    return totalRevenue;
  }
}
