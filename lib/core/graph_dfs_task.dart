import 'dart:collection';
import 'dart:math';

import 'package:dmiti_project/core/algorithms/graph_tree/GraphAnalysis.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:dmiti_project/core/graph_visualizer.dart';
import 'package:dmiti_project/res/colors.dart';

class DfsBfsTraversalTaskScreen extends StatefulWidget {
  final MyGraph graph;
  final bool isDfs;
  final bool isEducation;

  DfsBfsTraversalTaskScreen(
      {Key? key,
      required this.graph,
      required this.isDfs,
      required this.isEducation})
      : super(key: key);

  @override
  _DfsBfsTraversalTaskScreenState createState() =>
      _DfsBfsTraversalTaskScreenState();
}

class _DfsBfsTraversalTaskScreenState extends State<DfsBfsTraversalTaskScreen> {
  TextEditingController controller = TextEditingController();
  String correctAnswer = "";

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.isDfs
        ? GraphTraversal.dfsTraversal(widget.graph.graph, 1)
        : GraphTraversal.bfsTraversal(widget.graph.graph,
            1); // Используйте любую вершину в качестве начальной
  }

  void checkAnswer() {
    String userInput = controller.text.trim();
    bool isCorrect = userInput == correctAnswer;
    print(correctAnswer);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultDialog(
          context: context,
          colorButton: isCorrect ? AppColors.green : AppColors.redBackground,
          mainText: isCorrect ? "Успех" : "Неудача",
          infoText:
              isCorrect ? "Вы успешно решили задачу" : "Повторите попытку",
          buttonText: "Начать заново",
          onPressedFunction: () {
            Navigator.of(context).pop();
            controller.clear();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Column(
        children: [
          Center(
            child: Container(
              height: 350,
              width: 300,
              child: GraphWidget(
                graph: widget.graph.graph,
              ),
            ),
          ),
          Text(
              style: getTheme().textTheme.bodyLarge,
              "Выполните обход графа в глубину (DFS)"),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: GraphTextField(
              controller: controller,
              isEducation: widget.isEducation,
              answer: correctAnswer,
            ),
          ),
          DefaultButton(
            info: "Отправить",
            buttonColor: AppColors.green,
            onPressedFunction: widget.isEducation ? () {} : checkAnswer,
            isSettings: false,
          ),
        ],
      );
    }));
  }
}
