import 'package:dmiti_project/app/helper.dart';
import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/field_cell.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FieldMatrix extends StatefulWidget {
  final bool isExample;
  bool isSolved;
  final Task task;
  final Function(bool)? onAnswer;
  FieldMatrix(
      {Key? key,
      required this.task,
      required this.isSolved,
      required this.isExample,
      required this.onAnswer})
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
    for (List<int> dataList in widget.task.data) {
      if (count >= widget.task.linesCount) {
        break;
      }
      controllers.addAll(List.generate(
          dataList.length,
          (index) => TextEditingController(
              text:
                  widget.isExample == true ? dataList[index].toString() : '')));
      allData.addAll(dataList.map((item) => item.toString()));
      count++;
      _loadCounter();
    }
  }

  // Loading counter value on start
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Helper.counter = (prefs.getInt('counter') ?? 0);
    });
  }

  // Incrementing counter after click
  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Helper.counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', Helper.counter);
    });
  }

  @override
  void dispose() {
    // Вариант с удалением каждого контроллера
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
      for (List<int> dataList in widget.task.data) {
        if (count >= widget.task.linesCount) {
          break;
        }
        controllers.addAll(
            List.generate(dataList.length, (index) => TextEditingController()));
        allData.addAll(dataList.map((item) => item.toString()));
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
          return entry.value == allData[entry.key];
        })) {
      setState(() {
        widget.isSolved = true;
        _incrementCounter();
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
    //для теста версии с экзаменом, пока не убирать
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
        ..._buildMatrix(),
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
                    answer: number,
                    controller: controllers[controllerIndex++],
                    isExample: widget.isExample),
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
