import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/login/screens/login_screen.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final String imageAssetString = 'assets/images/logowhite.png';

  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final barcodeData = args["barcodeData"];
    final TextEditingController _productNameController =
        TextEditingController();
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
                    placeholder: "Product Name",
                    controller: _productNameController),
                SizedBox(height: 10),
                CustomTextInput(
                    placeholder: "Product Description",
                    controller: _productNameController),
                SizedBox(height: 10),
                CustomTextInput(
                    placeholder: "Stock Count",
                    controller: _productNameController),
                SizedBox(height: 10),
                CustomTextInput(
                    placeholder: "Buy Price",
                    controller: _productNameController),
                SizedBox(height: 10),
                CustomTextInput(
                    placeholder: "Sell Price",
                    controller: _productNameController),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: MainTheme.secondaryColor),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      print('Adınız: $_name');
                    }
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
