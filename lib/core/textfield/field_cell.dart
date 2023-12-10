import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

//Переписать следующим образом: передавать в клетку правильный ответ, в случае, если бул равен тру, вставлять ответ в ячейку, иначе делать длину ввода в качестве длины числа
class FieldCell extends StatefulWidget {
  final bool isExample;
  final int answer;
  final TextEditingController controller;
  const FieldCell(
      {Key? key,
      required this.answer,
      required this.controller,
      required this.isExample})
      : super(key: key);

  @override
  State<FieldCell> createState() => _FieldCellState();
}

class _FieldCellState extends State<FieldCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.grayContainer,
          borderRadius: BorderRadius.circular(16)),
      child: TextField(
        enabled: widget.isExample == false,
        controller: widget.controller,
        maxLength: widget.answer.toInt() >= 0
            ? widget.answer.toString().length
            : widget.answer.toString().length + 1,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        style: getTheme().textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.isExample == true ? widget.answer.toString() : '',
          hintStyle: getTheme().textTheme.bodyLarge,
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
