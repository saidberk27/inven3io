import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/shop%20details/models/shop_model.dart';

class ShopDetailsScreen extends StatefulWidget {
  ShopDetailsScreen({super.key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    late Shop displayShop;

    const String imageAssetString = 'assets/images/logowhite.png';
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String shopName = args['shopName'];

    switch (shopName) {
      case "TEŞVİKİYE":
        displayShop = Shop(
            shopName: "Teşvikiye",
            shopImage: "assets/images/tesvikiye.png",
            contactInfo: {
              "mobile": '+90 549 890 01 80',
              "tel": '+90 (212) 236 16 70',
              "email": 'ogoktepe@colorbox.com.tr'
            },
            shopID: '77O4SUWWd471oQGhjQEc');
        break;

      case "FENERBAHÇE":
        displayShop = Shop(
            shopName: "Fenerbahce",
            shopImage: "assets/images/fenerbahce.png",
            contactInfo: {
              "mobile": '+90 549 525 55 10',
              "tel": '+90 (216) 330 40 51',
              "email": 'eyazkan@colorbox.com.tr'
            },
            shopID: 'uFPmVPqJawrTbsgrjmHk');
        break;

      case "KOZYATAĞI":
        displayShop = Shop(
            shopName: "Kozyatağı",
            shopImage: "assets/images/kozyatagi.png",
            contactInfo: {
              "mobile": '+90 549 767 52 01',
              "tel": '+90 (216) 467 60 43',
              "email": 'onedimgirgin@colorbox.com.tr'
            },
            shopID: 'HEP9ZiWejjLLrMqJ8IJm');
        break;
    }

    return Scaffold(
      backgroundColor: MainTheme.secondaryColor,
      appBar: AppBar(
        title: Image.asset(imageAssetString),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: MainTheme.primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ShopHeader(displayShop: displayShop),
                        ),
                      )),
                  Expanded(
                      flex: 6,
                      child: Container(
                        color: MainTheme.fifthColor,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopHeader extends StatelessWidget {
  const ShopHeader({
    super.key,
    required this.displayShop,
  });

  final Shop displayShop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${displayShop.shopName} ColorBox",
            textAlign: TextAlign.center,
            style: MainTheme.themeData.textTheme.displaySmall,
          ),
          Image.asset(displayShop.shopImage),
          ContactTable(displayShop: displayShop)
        ],
      ),
    );
  }
}

class ContactTable extends StatelessWidget {
  const ContactTable({
    super.key,
    required this.displayShop,
  });

  final Shop displayShop;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(1), // Set the first column width to 1
        1: FlexColumnWidth(2), // Set the second column width to 2
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: MainTheme
                    .fourthColor, // Set the background color of the first cell to orange
                child: Center(
                  child: Text(
                    'Mobile',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: MainTheme.fifthColor,
                child: Center(
                  child: Text("${displayShop.contactInfo['mobile']}"),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: MainTheme
                    .fourthColor, // Set the background color of the second cell to red
                child: Center(
                  child: Text(
                    'Tel',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: MainTheme.fifthColor,
                child: Center(
                  child: Text("${displayShop.contactInfo['tel']}"),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                color: MainTheme.fourthColor,
                child: Center(
                  child: Text(
                    'E - Mail',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                color: MainTheme.fifthColor,
                child: Center(
                  child: Text("${displayShop.contactInfo['email']}"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
