import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final Color buttonColor;
  final String info;
  final VoidCallback onPressedFunction;
  const DefaultButton(
      {super.key,
      required this.info,
      required this.buttonColor,
      required this.onPressedFunction});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Закругление углов
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(const Size(217, 34)),
            backgroundColor:
                MaterialStateProperty.all<Color>(widget.buttonColor),
            textStyle: MaterialStateProperty.all<TextStyle?>(
                getTheme().textTheme.bodyLarge)),
        onPressed: widget.onPressedFunction,
        child: Text(widget.info,
            style: widget.buttonColor == AppColors.green
                ? getTheme().textTheme.labelSmall
                : getTheme().textTheme.labelLarge));
  }
}
