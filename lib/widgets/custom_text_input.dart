import 'package:flutter/material.dart';
import '../config/themes/main_theme.dart';

class CustomTextInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isNumeric;
  final IconData inputIcon;

  const CustomTextInput(
      {Key? key,
      required this.placeholder,
      required this.controller,
      required this.inputIcon,
      this.isPassword,
      this.isNumeric})
      : super(key: key);

  @override
  CustomTextInputState createState() => CustomTextInputState();
}

class CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainTheme.primaryColor, // Border color
          width: 4.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      child: TextFormField(
        
        key: widget.key, // Unique key for each TextFormField
        obscureText: widget.isPassword ?? false,
        keyboardType: widget.isNumeric != null
            ? TextInputType.number
            : TextInputType.text,
        controller: widget.controller,
        style: MainTheme.themeData.textTheme.displaySmall!
            .copyWith(color: MainTheme.thirdColor),
        decoration: InputDecoration(
          hintStyle: MainTheme.themeData.textTheme.displaySmall!
              .copyWith(color: MainTheme.thirdColor),
              prefixIcon: Icon(widget.inputIcon),
              prefixIconColor: MainTheme.primaryColor,
          hintText: widget.placeholder, // Placeholder text
          border: InputBorder.none, // Remove the default underline border
        ),
      ),
    );
  }
}
