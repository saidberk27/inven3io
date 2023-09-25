import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/themes/main_theme.dart';
import '../../../data/authentication.dart';
import '../../../widgets/custom_text_input.dart';
import '../../../widgets/title_semi_round.dart';
import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final String imageAssetString = 'assets/images/logowhite.png';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Image.asset(imageAssetString)),
      body: SafeArea(
          child: Center(
        child: Stack(children: [
          LogoAndFormSection(
              screenHeight: screenHeight, imageAssetString: imageAssetString),
        ]),
      )),
    );
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
                buttonText: "Create User",
                buttonFunction: () async {
                  FormState formState = FormSection._formKey.currentState!;

                  if (formState.validate()) {
                    String emailAddress = _mailController.text;
                    String password = _passwordController.text;

                    try {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("User is being created..."),
                          duration: Duration(milliseconds: 1500)));
                      if (await createUserWithEmailAndPassword(
                          emailAddress: emailAddress,
                          password: password,
                          context: context)) {
                        Navigator.pushReplacementNamed(context, '/login');
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("User succesfully created!"),
                                duration: Duration(milliseconds: 750)));
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

Future<dynamic> createUserWithEmailAndPassword(
    {required String emailAddress,
    required String password,
    required BuildContext context}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Authentication authentication =
        Authentication(emailAddress: emailAddress, password: password);

    dynamic result = await authentication.createUserWithEmailAndPassword();

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
