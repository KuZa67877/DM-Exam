import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/task_interface.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/field_cell.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';

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
        var dimen = 0.0;
        if (controllerIndex < controllers.length) {
          var fieldCell = FieldCell(
            answer: number,
            controller: controllers[controllerIndex++],
            isExample: widget.isExample,
            isEducation: widget.isEducation,
            key: UniqueKey(),
          );
          dynamic myChild = fieldCell;

          // Простите меня, пожалуйста
          if (controllerIndex == maxLength * 4 + 2 &&
              widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "a1:",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  fieldCell,
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "b1:",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          } else if (controllerIndex == maxLength * 4 + 4 &&
              widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "c1:",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  fieldCell,
                ],
              ),
            );
          } else if (controllerIndex == maxLength * 4 + 5 &&
              widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "x=",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  fieldCell,
                ],
              ),
            );
          } else if (controllerIndex == maxLength * 4 + 7 &&
              widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "y=",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  fieldCell,
                ],
              ),
            );
          }
          if ((controllerIndex == maxLength * 4 + 6) ||
              (controllerIndex == maxLength * 4 + 8) &&
                  widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "+",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  fieldCell,
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "t",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          } else if (controllerIndex == maxLength * 4 + 1 &&
              widget.task.linesCount == 8) {
            myChild = Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text(
                    "НОД:",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  fieldCell,
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: dimen),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: myChild,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      }).toList();
      //controllerIndex++;
      // Добавление SizedBox в конец строки, если длина строки меньше максимальной
      int diff = maxLength - children.length;
      if (diff > 0 && widget.task.linesCount != 8) {
        children.addAll(List.filled(diff, SizedBox(width: 50, height: 50)));
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: line.map((number) {
          if (controllerIndex < controllers.length) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3, right: 3),
                child: FieldCell(
                  answer: number,
                  controller: controllers[controllerIndex++],
                  isExample: widget.isExample,
                  isEducation: widget.isEducation,
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }).toList(),
      );
    }).toList();
  }
}
