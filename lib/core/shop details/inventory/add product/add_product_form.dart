import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/shop%20details/inventory/add%20product/product.dart';
import 'package:inven3io/core/shop%20details/inventory/viewmodels/inventory_vm.dart';
import 'package:inven3io/data/firestore.dart';
import 'package:inven3io/widgets/custom_text_input.dart';

import '../../models/shop_model.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final String imageAssetString = 'assets/images/logowhite.png';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String barcodeData = args["barcodeData"];
    final Shop shop = args["currentShop"];
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productDescController = TextEditingController();
    final TextEditingController buyPriceController = TextEditingController();
    final TextEditingController sellPriceController = TextEditingController();
    final InventoryViewModel vm = InventoryViewModel();
    return Scaffold(
      appBar: AppBar(title: Image.asset(imageAssetString)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Barcode: $barcodeData",
                  style: MainTheme.themeData.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                CustomTextInput(
                  inputIcon: Icons.abc,
                    placeholder: "Product Name",
                    controller: productNameController),
                const SizedBox(height: 10),
                CustomTextInput(                  
                  inputIcon: Icons.abc,
                  placeholder: "Product Description",
                  controller: productDescController,
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                    inputIcon: Icons.attach_money,
                    placeholder: "Buy Price",
                    controller: buyPriceController,
                    isNumeric: true),
                const SizedBox(height: 10),
                CustomTextInput(
                    inputIcon: Icons.attach_money,
                    placeholder: "Sell Price",
                    controller: sellPriceController,
                    isNumeric: true),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MainTheme.secondaryColor),
                  onPressed: () {
                    Firestore db = Firestore();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    
                    Product product = Product(
                        productName: productNameController.text,
                        productDesc: productDescController.text,
                        productBarcode: barcodeData,
                        buyPrice: double.parse(buyPriceController.text),
                        sellPrice: double.parse(sellPriceController.text));

                    db.addDocumentWithCustomID(
                        collectionPath: "/shops/${shop.shopID}/products",
                        customID: barcodeData,
                        document: product.toJson());
                    vm.log(
                        procces: "ADD",
                        productName: product.productName,
                        barcodeData: product.productBarcode,
                        sellPrice: product.sellPrice,
                        shopName: shop.shopName);
                    Navigator.of(context).pushReplacementNamed("/home");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Product Succesfully Added to Database")));
                  },
                  child: Text(
                    'Submit',
                    style: MainTheme.themeData.textTheme.displaySmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
