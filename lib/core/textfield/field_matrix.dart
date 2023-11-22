import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/field_cell.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';

import 'package:flutter/material.dart';

class FieldMatrix extends StatefulWidget {
  bool isSolved;
  final Task task;
  FieldMatrix({Key? key, required this.task, required this.isSolved})
      : super(key: key);

  @override
  State<FieldMatrix> createState() => _FieldMatrixState();
}

class _FieldMatrixState extends State<FieldMatrix> {
  List<TextEditingController> controllers = []; // Добавлено
  List<String> allData = []; // Перенесено сюда

  @override
  void initState() {
    super.initState();
    for (List<int> dataList in widget.task.data) {
      for (int i = 0; i < dataList.length; i++) {
        allData.add(dataList[i].toString());
        controllers.add(TextEditingController()); // Создание контроллеров здесь
      }
    }
  }

  // @override
  // void dispose() {
  //   // Вариант с удалением каждого контроллера
  //   controllers.forEach((controller) => controller.dispose());

  //   super.dispose();
  // }

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
      for (List<int> dataList in widget.task.data) {
        for (int i = 0; i < dataList.length; i++) {
          allData.add(dataList[i].toString());
          controllers
              .add(TextEditingController()); // Создание контроллеров здесь
        }
      }
    }
  }

  void printValues() {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildMatrix(),
        DefaultButton(
          buttonColor: AppColors.green,
          info: AppStrings.send,
          onPressedFunction: printValues,
        ),
      ],
    );
  }

  List<Widget> _buildMatrix() {
    var allLines = [
      widget.task.firstline,
      widget.task.secondline,
      widget.task.thirdline,
      widget.task.fourthLine,
    ];

    int controllerIndex = 0;
    return allLines.map((line) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: line.map((number) {
          // Защита от обращения к элементу вне диапазона
          if (controllerIndex < controllers.length) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3, right: 3),
                child: FieldCell(
                  maxLenght: number.toString().length,
                  controller: controllers[controllerIndex++],
                ),
              ),
            );
          } else {
            return SizedBox(); // Хз, можно убрать в дальнейшем
          }
        }).toList(),
      );
    }).toList();
  }
}
