import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/textfield/field_matrix.dart';
import 'package:dmiti_project/core/task_info.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class FullTask extends StatefulWidget {
  final bool isExample;

  bool isSolved;
  Task taskGenerator;
  String helpText = "Показать подсказку";
  final Function(bool)? onAnswer;
  FullTask(
      {super.key,
      required this.isSolved,
      required this.taskGenerator,
      required this.isExample,
      required this.onAnswer});

  @override
  State<FullTask> createState() => _FullTaskState();
}

class _FullTaskState extends State<FullTask> {
  bool _isTextVisible = false;
  void _toggleTextVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible;
      answer = "${widget.taskGenerator.firstline.join(" ")}";
      widget.helpText =
          !_isTextVisible ? "Показать подсказку" : "Скрыть подсказку";
    });
  }

  int _correctAnswers = 0;
  String answer = "";

  late FieldMatrix matrix;
  @override
  void initState() {
    super.initState();
    matrix = FieldMatrix(
      task: widget.taskGenerator,
      isSolved: widget.isSolved,
      isExample: widget.isExample,
      onAnswer: widget.onAnswer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TaskInfo(taskGenerator: widget.taskGenerator),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppStrings.writeAnswer,
              style: getTheme().textTheme.bodyLarge,
            ),
          ),
          FieldMatrix(
            task: widget.taskGenerator,
            isSolved: widget.isSolved,
            isExample: widget.isExample,
            onAnswer: widget.onAnswer,
          ),
          if (!widget.isExample && widget.onAnswer == null)
            TextButton(
                onPressed: _toggleTextVisibility,
                child: Text(
                  widget.helpText,
                  style: getTheme().textTheme.bodySmall,
                )),
          _isTextVisible
              ? Text(
                  "$answer",
                  style: getTheme().textTheme.bodyLarge,
                )
              : Container()
        ],
      ),
    );
  }
}
