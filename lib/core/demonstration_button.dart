import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class DemonstrationButton extends StatefulWidget {
  final String info;
  const DemonstrationButton({super.key, required this.info});

  @override
  State<DemonstrationButton> createState() => _DemonstrationButtonState();
}

class _DemonstrationButtonState extends State<DemonstrationButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Закругление углов
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(const Size(100, 24)),
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.green),
            textStyle: MaterialStateProperty.all<TextStyle?>(
                getTheme().textTheme.bodyLarge)),
        onPressed: () {},
        child: Text(widget.info, style: getTheme().textTheme.labelSmall));
    ;
  }
}
