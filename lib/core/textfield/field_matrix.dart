import 'dart:math';

import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/task_interface.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/field_cell.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';

import 'package:flutter/material.dart';

class FieldMatrix extends StatefulWidget {
  final bool isEducation;
  final bool isExample;
  bool isSolved;
  final Task task;
  final Function(bool)? onAnswer;
  FieldMatrix(
      {Key? key,
      required this.task,
      required this.isSolved,
      required this.isExample,
      required this.onAnswer,
      required this.isEducation})
      : super(key: key);

  @override
  State<FieldMatrix> createState() => _FieldMatrixState();
}

class _FieldMatrixState extends State<FieldMatrix> {
  List<TextEditingController> controllers = [];
  List<String> allData = [];

  @override
  void initState() {
    super.initState();
    int count = 0;
    for (List<int> line in widget.task.lines) {
      if (count >= widget.task.linesCount) {
        break;
      }
      controllers.addAll(List.generate(
          line.length,
          (index) => TextEditingController(
              text: widget.isExample == true ? line[index].toString() : '')));
      allData.addAll(line.map((item) => item.toString()));
      count++;
    }
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());

    super.dispose();
  }

  List<String> getValues() {
    return controllers
        .where((controller) => controller.text != null)
        .map((controller) => controller.text ?? '') //TODO исправить условие
        .toList();
  }

  @override
  void didUpdateWidget(covariant FieldMatrix oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.task != widget.task) {
      controllers.clear();
      allData.clear();
      int count = 0;
      for (List<int> line in widget.task.lines) {
        if (count >= widget.task.linesCount) {
          break;
        }
        controllers.addAll(
            List.generate(line.length, (index) => TextEditingController()));
        allData.addAll(line.map((item) => item.toString()));
        count++;
      }
    }
  }

  void printValues() {
    List<String> inputValues = getValues();

    print(inputValues);
    print(allData);
    if (inputValues.length == allData.length &&
        inputValues.asMap().entries.every((entry) {
          return entry.value == allData[entry.key] ||
              (entry.value == '' && allData[entry.key] == '0');
        })) {
      setState(() {
        widget.isSolved = true;
      });
      showDialog(
        context: context,
        builder: (_) => DefaultDialog(
            context: context,
            colorButton: AppColors.green,
            mainText: AppStrings.success,
            infoText: AppStrings.goodSolution,
            buttonText: AppStrings.continueText,
            onPressedFunction: () {
              Navigator.of(context).pop();
            }),
      );
    } else {
      setState(() {
        widget.isSolved = false;
      });
      showDialog(
        context: context,
        builder: (_) => DefaultDialog(
            context: context,
            colorButton: AppColors.redBackground,
            mainText: AppStrings.fail,
            infoText: AppStrings.badSolution,
            buttonText: AppStrings.continueText,
            onPressedFunction: () {
              Navigator.of(context).pop();
            }),
      );
    }
  }

  void printValues1() {
    List<String> inputValues = getValues();

    print(inputValues);
    print(allData);
    if (inputValues.length == allData.length &&
        inputValues.asMap().entries.every((entry) {
          return entry.value == allData[entry.key];
        })) {
      setState(() {
        widget.isSolved = true;
      });
      widget.onAnswer!(true);
    } else {
      setState(() {
        widget.isSolved = false;
      });
      widget.onAnswer!(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(children: [..._buildMatrix()]),
        ),
        DefaultButton(
          buttonColor: AppColors.green,
          info: AppStrings.send,
          onPressedFunction:
              widget.onAnswer == null ? printValues : printValues1,
          isSettings: false,
        ),
      ],
    );
  }

//   void switchTask() {
//    setState(() {
//      // Обновляем ключи всех FieldCell
//      for (var i = 0; i < controllers.length; i++) {
//        controllers[i].key = UniqueKey();
//      }
//    });
//  }

  List<Widget> _buildMatrix() {
    var allLines = widget.task.lines;
    final maxLength = widget.task.lines[0].length;

    int controllerIndex = 0;
    return allLines.map((line) {
      var children = line.map((number) {
        if (controllerIndex < controllers.length) {
          return SingleChildScrollView(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: FieldCell(
                    answer: number,
                    controller: controllers[controllerIndex++],
                    isExample: widget.isExample,
                    isEducation: widget.isEducation,
                    key1: UniqueKey(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      }).toList();

      // Добавление SizedBox в конец строки, если длина строки меньше максимальной
      int diff = maxLength - children.length;
      if (diff > 0) {
        children.addAll(List.filled(diff, SizedBox(width: 50, height: 50)));
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }).toList();
  }
}
