import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/login/models/user.dart';
import 'package:inven3io/data/authentication.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/custom_text_input.dart';

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

class FormSection extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  const FormSection({
    super.key,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: FormSection._formKey,
      child: Column(
        children: [
          CustomTextInput(
            placeholder: "E - Posta",
            controller: _mailController,
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            placeholder: "Şifre",
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              LoginPageButtons(
                buttonText: "Üye Ol",
                buttonFunction: () {},
              ),
              LoginPageButtons(
                buttonText: "Giriş Yap",
                buttonFunction: () async {
                  FormState formState = FormSection._formKey.currentState!;

                  if (formState.validate()) {
                    String emailAddress = _mailController.text;
                    String password = _passwordController.text;

                    try {
                      // Sign in the user with the given email address and password.
                      if (await signInWithEmailAndPassword(
                          emailAddress: emailAddress,
                          password: password,
                          context: context)) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
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
    {required String emailAddress,
    required String password,
    required BuildContext context}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Authentication authentication =
        Authentication(emailAddress: emailAddress, password: password);

    dynamic result = await authentication.signInWithEmailAndPassword();

    if (result != null) {
      if (result is String) {
        return false;
      } else {
        User user = User(
            username: "username",
            password: "security reasons",
            userID: result.user.email,
            mail: result.user.email);
        await prefs.setString("SessionMail", emailAddress);
        return true;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kullanıcı adı veya Şifre Hatalı")),
      );
    }
    return false;
  } on Exception catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
