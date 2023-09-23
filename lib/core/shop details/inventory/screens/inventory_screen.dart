import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/shop%20details/inventory/add%20product/product.dart';
import 'package:inven3io/core/shop%20details/inventory/viewmodels/inventory_vm.dart';
import 'package:inven3io/data/firestore.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../models/shop_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final String imageAssetString = 'assets/images/logowhite.png';
  String barcodeData = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Shop currentShop = args["currentShop"];
    String currentShopID = currentShop.shopID;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(imageAssetString),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          "Scan Barcode",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        icon: const Icon(Icons.qr_code_scanner),
        onPressed: () async {
          barcodeData = await barcodeScanner();

          Firestore db = Firestore();
          Map<String, dynamic> barcodeRelatedFile = await db.readSingleDocument(
              collectionPath: "shops/$currentShopID/products",
              documentID: barcodeData);

          if (barcodeRelatedFile["status"] == "no file found") {
            print("First Detection of Barcode");
            warningBottomSheet(context, currentShop: currentShop);
          } else {
            print("Product has already added previously.");
            succesBottomSheet(context,
                currentShop: currentShop,
                soldProduct: Product.fromJson(json: barcodeRelatedFile));
          }
        },
      ),
      body: const Center(
        child: Text("Inventory"),
      ),
    );
  }

  Future<dynamic> succesBottomSheet(BuildContext context,
      {required Shop currentShop, required Product soldProduct}) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: MainTheme.fifthColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Text(
                "Product is Available on Database",
                textAlign: TextAlign.center,
                style: MainTheme.themeData.textTheme.displayLarge!
                    .copyWith(color: MainTheme.secondaryColor),
              ),
              Text("Barcode Number: $barcodeData",
                  style: MainTheme.themeData.textTheme.displaySmall!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  InventoryViewModel vm = InventoryViewModel();
                  vm.sellProduct(product: soldProduct, shop: currentShop);
                },
                child: Text(
                  "Sell Product",
                  style: MainTheme.themeData.textTheme.displaySmall!
                      .copyWith(color: Colors.white),
                ),
                style:
                    ElevatedButton.styleFrom(primary: MainTheme.secondaryColor),
              )
            ]),
          );
        });
  }

  Future<dynamic> warningBottomSheet(BuildContext context,
      {required Shop currentShop}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: MainTheme.fifthColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Product Not Found on Database!",
                textAlign: TextAlign.center,
                style: MainTheme.themeData.textTheme.displayLarge!
                    .copyWith(color: MainTheme.secondaryColor),
              ),
              Text("Barcode Number: $barcodeData",
                  style: MainTheme.themeData.textTheme.displaySmall!),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/addProductForm", arguments: {
                    "barcodeData": barcodeData,
                    "currentShop": currentShop
                  });
                },
                child: Text(
                  "Add Product",
                  style: MainTheme.themeData.textTheme.displaySmall!
                      .copyWith(color: Colors.white),
                ),
                style:
                    ElevatedButton.styleFrom(primary: MainTheme.secondaryColor),
              )
            ],
          ),
        );
      },
    );
  }

  Future<String> barcodeScanner() async {
    /*var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        )); */

    var res = "9781234567897";
    setState(() {
      barcodeData = res;
    });
    return barcodeData;
  }
}
