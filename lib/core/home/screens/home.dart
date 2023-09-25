import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';

import '../../../widgets/title_semi_round.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String imageAssetString = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(imageAssetString),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 16, left: 16, bottom: 0),
                  child: Stack(
                    children: [
                      MainContainer(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      TitleSemiRound(
                        title:"SELECT\nCOLORBOX\nSTORE",
                          screenWidth: screenWidth, screenHeight: screenHeight),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight / 1.5,
        width: screenWidth,
        color: MainTheme.secondaryColor,
        child: Column(
          children: [
            const Expanded(flex: 55, child: SizedBox()),
            Expanded(
                flex: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ShopSection(
                          image: 'assets/images/tesvikiye.png',
                          shopName: 'TEŞVİKİYE',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight),
                      const SizedBox(height: 20),
                      ShopSection(
                          image: 'assets/images/fenerbahce.png',
                          shopName: 'FENERBAHÇE',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight),
                      const SizedBox(height: 20),
                      ShopSection(
                          image: 'assets/images/kozyatagi.png',
                          shopName: 'KOZYATAĞI',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight),
                    ],
                  ),
                ))
          ],
        ));
  }
}

class ShopSection extends StatelessWidget {
  ShopSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.image,
    required this.shopName,
  });

  final double screenWidth;
  final double screenHeight;
  late String image;
  late String shopName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/shop',
          arguments: {
            'shopName': shopName
          }, // Replace 'YourShopNameHere' with the actual shop name
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image, // Replace with your image path
            width: screenWidth / 2, // Adjust the image width
          ),
          Container(
            width: screenWidth / 2.5, // Adjust the width as needed
            height: screenHeight / 18, // Adjust the height as needed
            decoration: BoxDecoration(
              color: MainTheme.fourthColor, // Set the background color
              borderRadius:
                  BorderRadius.circular(30.0), // Adjust the corner radius
            ),
            child: Center(
              child: Text(
                shopName,
                style: MainTheme.themeData.textTheme.displaySmall!
                    .copyWith(color: MainTheme.thirdColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}



