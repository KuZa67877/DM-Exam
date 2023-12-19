import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  final String mainText;
  final String infoText;
  final String buttonText;
  final Color colorButton;
  final VoidCallback onPressedFunction;
  DefaultDialog(
      {super.key,
      required this.context,
      required this.colorButton,
      required this.mainText,
      required this.infoText,
      required this.buttonText,
      required this.onPressedFunction});

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 273,
        height: 187,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              mainText,
              style: getTheme().textTheme.bodyLarge,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(infoText, style: getTheme().textTheme.bodyLarge),
            ),
          ),
          if (buttonText != "Начать заново")
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: DefaultButton(
                info: buttonText,
                buttonColor: colorButton,
                onPressedFunction: onPressedFunction,
                isSettings: false,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: DefaultButton(
                info: buttonText,
                buttonColor: colorButton,
                onPressedFunction: onPressedFunction,
                isSettings: false,
              ),
            )
        ]),
      ),
    );
  }
}
