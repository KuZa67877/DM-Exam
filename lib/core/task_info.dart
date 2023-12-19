// import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/algorithms/task_interface.dart';

import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class TaskInfo extends StatelessWidget {
  final Task taskGenerator;

  const TaskInfo({super.key, required this.taskGenerator});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          width: 330,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                taskGenerator.writeQuestion(),
                style: getTheme().textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ])),
    );
  }
}
