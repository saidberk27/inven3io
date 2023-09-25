import 'package:flutter/material.dart';

import '../config/themes/main_theme.dart';

class TitleSemiRound extends StatelessWidget {
  late String title;
   TitleSemiRound({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
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
