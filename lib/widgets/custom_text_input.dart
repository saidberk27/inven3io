import 'package:flutter/material.dart';
import '../config/themes/main_theme.dart';

class CustomTextInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool? isPassword;

  const CustomTextInput({
    Key? key,
    required this.placeholder,
    required this.controller,
    this.isPassword,
  }) : super(key: key);

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
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
        key: widget.key, // Unique key for each TextFormField
        obscureText: widget.isPassword ?? false,
        controller: widget.controller,
        style: MainTheme.themeData.textTheme.displaySmall!
            .copyWith(color: MainTheme.thirdColor),
        decoration: InputDecoration(
          hintStyle: MainTheme.themeData.textTheme.displaySmall!
              .copyWith(color: MainTheme.thirdColor),
          hintText: widget.placeholder, // Placeholder text
          border: InputBorder.none, // Remove the default underline border
        ),
      ),
    );
  }
}
