import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

//Will bu use later
class QuickPowDialog extends StatelessWidget {
  var number;
  QuickPowDialog({
    super.key,
    required this.context,
    required this.number,
  });

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 293,
        height: 250,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "Какое действие вы хотите выполнить?",
              style: getTheme().textTheme.bodyLarge,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Умножить на основание число ${number} или возвести его в квадрат",
                  style: getTheme().textTheme.bodyLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                DefaultButton(
                  info: "Умножить на основание",
                  buttonColor: AppColors.green,
                  onPressedFunction: () {},
                  isSettings: false,
                ),
                DefaultButton(
                  info: "Возвести в квадрат",
                  buttonColor: AppColors.green,
                  onPressedFunction: () {},
                  isSettings: false,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
