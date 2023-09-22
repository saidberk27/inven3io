import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final String imageAssetString = 'assets/images/logowhite.png';
  String barcodeData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(imageAssetString),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            /*var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                )); */

            var res = "9781234567897";
            setState(() {
              barcodeData = res;
              print(barcodeData);
                        });
          },
          child: const Text('Open Scanner'),
        ),
      ),
    );
  }
}
