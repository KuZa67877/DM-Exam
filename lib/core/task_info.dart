import 'package:dmiti_project/core/algorithms/evklid_classes.dart';

import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class TaskInfo extends StatelessWidget {
  final Task taskGenerator;
  final String info;
  const TaskInfo({super.key, required this.taskGenerator, required this.info});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          width: 330,
          child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                info,
                style: getTheme().textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
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
