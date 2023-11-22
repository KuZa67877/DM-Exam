import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class FieldCell extends StatefulWidget {
  final int maxLenght;
  final TextEditingController controller; // добавлено
  const FieldCell({Key? key, required this.maxLenght, required this.controller})
      : super(key: key);

  @override
  State<FieldCell> createState() => _FieldCellState();
}

class _FieldCellState extends State<FieldCell> {
  //final textController = TextEditingController(); Перенесено в параметры

  // @override
  // void dispose() {
  //   // textController.dispose(); Изменено
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.grayContainer,
          borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: widget.controller, // Изменено
        maxLength: widget.maxLenght,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        style: getTheme().textTheme.bodyLarge,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
