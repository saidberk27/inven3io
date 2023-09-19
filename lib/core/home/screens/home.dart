import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';

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
                  padding:
                      EdgeInsets.only(top: 0, right: 16, left: 16, bottom: 0),
                  child: Stack(
                    children: [
                      MainContainer(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      TitleSemiRound(
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
        height: screenHeight / 1.6,
        width: screenWidth,
        color: MainTheme.secondaryColor,
        child: Column(
          children: [
            Expanded(flex: 55, child: SizedBox()),
            Expanded(
                flex: 100,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        ShopSection(
                            image: 'assets/images/tesvikiye.png',
                            text: 'TEŞVİKİYE',
                            screenWidth: screenWidth,
                            screenHeight: screenHeight),
                        SizedBox(height: 20),
                        ShopSection(
                            image: 'assets/images/fenerbahce.png',
                            text: 'FENERBAHÇE',
                            screenWidth: screenWidth,
                            screenHeight: screenHeight),
                        SizedBox(height: 20),
                        ShopSection(
                            image: 'assets/images/kozyatagi.png',
                            text: 'KOZYATAĞI',
                            screenWidth: screenWidth,
                            screenHeight: screenHeight),
                      ],
                    ),
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
    required this.text,
  });

  final double screenWidth;
  final double screenHeight;
  late String image;
  late String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(text);
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
                text,
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

class TitleSemiRound extends StatelessWidget {
  final String title = "SELECT\nCOLORBOX\nSTORE";
  const TitleSemiRound({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;
  final int angle = 180;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * (3.14159265359 / 180),
      child: ClipPath(
        clipper: CustomClip(),
        child: Container(
          width: screenWidth,
          height: screenHeight / 4.5,
          color: MainTheme.fourthColor,
          child: Transform.rotate(
              angle: angle * (3.14159265359 / 180),
              child: Center(
                  child: Text(
                title,
                style: MainTheme.themeData.textTheme.displayLarge!
                    .copyWith(color: MainTheme.thirdColor, fontSize: 30),
                textAlign: TextAlign.center,
              ))),
        ),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 200;

    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
