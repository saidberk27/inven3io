import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inven3io/core/shop%20details/inventory/add%20product/product.dart';
import 'package:inven3io/data/firestore.dart';

import '../../models/shop_model.dart';

class InventoryViewModel {
  Future<List<Map<String, dynamic>>> getAllProducts({required Shop shop}) {
    Firestore db = Firestore();
    return db.readDocumentsOfCollection(
        collectionPath: "shops/${shop.shopID}/products");
  }

  Future<bool> sellProduct(
      {required Product product, required Shop shop}) async {
    Firestore db = Firestore();
    try {
      await db.addDocument(
          collectionPath: "/shops/${shop.shopID}/sold",
          document: product.toJson());

      await db.removeDocument(
          collectionPath: "/shops/${shop.shopID}/products",
          documentID:
              product.productBarcode); // document ID = product barcode data
      await log(
          procces: "SELL",
          productName: product.productName,
          barcodeData: product.productBarcode,
          sellPrice: product.sellPrice,
          shopName: shop.shopName);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> log(
      {required String procces,
      required String productName,
      required String barcodeData,
      required double sellPrice,
      required String shopName}) async {
    Firestore db = Firestore();
    Map<String, dynamic> logData;
    if (procces == "ADD" || procces == "SELL") {
      logData = {
        "procces": procces,
        "productName": productName,
        "barcodeData": barcodeData,
        "sellPrice": sellPrice,
        "shopName": shopName,
        "timeStamp": Timestamp.fromDate(DateTime.now())
      };

      db.addDocument(collectionPath: "/logs/", document: logData);
    } else {
      print("Log Procces Invalid. Try either ADD or SELL");
    }
  }
}
