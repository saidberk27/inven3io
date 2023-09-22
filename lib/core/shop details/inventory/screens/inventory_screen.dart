import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final String imageAssetString = 'assets/images/logowhite.png';

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {
          Navigator.pushNamed(context, '/barcode');
        },
      ),
      body: const Center(
        child: Text("Inventory"),
      ),
    );
  }
}
