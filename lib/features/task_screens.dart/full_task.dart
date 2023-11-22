import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/textfield/field_matrix.dart';
import 'package:dmiti_project/core/task_info.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class FullTask extends StatefulWidget {
  final String taskInfo;
  bool isSolved;
  Task taskGenerator;
  FullTask(
      {super.key,
      required this.isSolved,
      required this.taskGenerator,
      required this.taskInfo});

  @override
  State<FullTask> createState() => _FullTaskState();
}

class _FullTaskState extends State<FullTask> {
  late FieldMatrix matrix;
  @override
  void initState() {
    super.initState();
    matrix = FieldMatrix(task: widget.taskGenerator, isSolved: widget.isSolved);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TaskInfo(taskGenerator: widget.taskGenerator, info: widget.taskInfo),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppStrings.writeAnswer,
              style: getTheme().textTheme.bodyLarge,
            ),
          ),
          FieldMatrix(task: widget.taskGenerator, isSolved: widget.isSolved),
        ],
      ),
    );
  }
}
