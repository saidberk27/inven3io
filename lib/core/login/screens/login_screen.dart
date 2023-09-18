import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/data/authentication.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const LoginScreen());

/// Stateful widget to fetch and then display video content.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late VideoPlayerController _controller;
  final String videoAssetString = 'assets/videos/login_video4.mp4';
  final String imageAssetString = 'assets/images/logo.png';
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoAssetString)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          VideoSection(controller: _controller),
          LogoAndFormSection(
              screenHeight: screenHeight, imageAssetString: imageAssetString),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class LogoAndFormSection extends StatelessWidget {
  const LogoAndFormSection({
    super.key,
    required this.screenHeight,
    required this.imageAssetString,
  });

  final double screenHeight;
  final String imageAssetString;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: screenHeight / 1.5,
        decoration: BoxDecoration(
            border: Border.all(color: MainTheme.secondaryColor, width: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: [Image.asset(imageAssetString), const FormSection()],
          ),
        ),
      ),
    ));
  }
}

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextInput(
          placeholder: "E - Posta",
        ),
        const SizedBox(height: 10),
        CustomTextInput(
          placeholder: "Şifre",
        ),
        const SizedBox(height: 10),
        ButtonBar(
          children: [
            LoginPageButtons(
              buttonText: "Üye Ol",
              buttonFunction: () {
                signInWithEmailAndPassword(
                    emailAddress: "csaidberk@gmail.com", password: "dxdiag27?");
              },
            ),
            LoginPageButtons(
              buttonText: "Giriş Yap",
              buttonFunction: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class LoginPageButtons extends StatelessWidget {
  late String buttonText;
  late void Function()? buttonFunction;
  LoginPageButtons(
      {super.key, required this.buttonText, required this.buttonFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonFunction,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        buttonText,
        style: MainTheme.themeData.textTheme.displaySmall!
            .copyWith(color: MainTheme.thirdColor),
      ),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  late String placeholder;
  CustomTextInput({
    super.key,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainTheme.secondaryColor, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      child: TextFormField(
        style: MainTheme.themeData.textTheme.displaySmall!
            .copyWith(color: MainTheme.thirdColor),
        decoration: InputDecoration(
          hintStyle: MainTheme.themeData.textTheme.displaySmall!
              .copyWith(color: MainTheme.thirdColor),
          hintText: placeholder, // Placeholder text
          border: InputBorder.none, // Remove the default underline border
        ),
      ),
    );
  }
}

class VideoSection extends StatelessWidget {
  const VideoSection({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}

Future<dynamic> signInWithEmailAndPassword(
    {required String emailAddress, required String password}) async {
  print("Signing In...");
  Authentication authentication =
      Authentication(emailAddress: emailAddress, password: password);

  dynamic result = await authentication.signInWithEmailAndPassword();
  print(result);
}
