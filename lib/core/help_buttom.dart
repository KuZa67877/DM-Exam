import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

class HelpButton extends StatefulWidget {
  //final VoidCallback showSolutionDialog;
  const HelpButton({
    super.key,
  });

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, //Идея - при нескольких тапах оставить пасхалку, :)))
      child: Container(
        width: 54,
        height: 54,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          Icons.question_mark_outlined,
          size: 24,
          color: AppColors.white,
        ),
      ),
    );
  }
}
