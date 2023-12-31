import 'package:flutter/material.dart';
import 'package:inven3io/config/themes/main_theme.dart';
import 'package:inven3io/core/login/models/user.dart';
import 'package:inven3io/data/authentication.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/custom_text_input.dart';
import '../../../widgets/title_semi_round.dart';

void main() => runApp(const LoginScreen());

/// Stateful widget to fetch and then display video content.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String imageAssetString = 'assets/images/logo.png';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            LogoAndFormSection(
                screenHeight: screenHeight, imageAssetString: imageAssetString),
            TitleSemiRound(
                title: "LOG IN TO\nCONTINUE",
                screenWidth: screenWidth,
                screenHeight: screenHeight),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: screenHeight / 1.5,
      decoration: BoxDecoration(
        color: MainTheme.secondaryColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [Image.asset(imageAssetString), const FormSection()],
        ),
      ),
    );
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
            inputIcon: Icons.mail,
            placeholder: "E - Mail",
            controller: _mailController,
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            inputIcon: Icons.password_sharp,
            placeholder: "Password",
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              LoginPageButtons(
                buttonText: "Sign Up",
                buttonFunction: () {
                  Navigator.pushNamed(context, "/signUp");
                },
              ),
              LoginPageButtons(
                buttonText: "Sign In",
                buttonFunction: () async {
                  FormState formState = FormSection._formKey.currentState!;

                  if (formState.validate()) {
                    String emailAddress = _mailController.text;
                    String password = _passwordController.text;

                    try {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("You are signing in..."),
                          duration: Duration(milliseconds: 1500)));
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
        const SnackBar(content: Text("Username or Password is Wrong")),
      );
    }
    return false;
  } on Exception catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
