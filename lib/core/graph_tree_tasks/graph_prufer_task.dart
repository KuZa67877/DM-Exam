import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphAnalysis.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_visualizer.dart';
import 'package:dmiti_project/res/colors.dart';

class PrueferCodeTaskScreen extends StatefulWidget {
  final MyGraph graph;
  final bool isEducation;
  PrueferCodeTaskScreen(
      {Key? key, required this.graph, required this.isEducation})
      : super(key: key);

  @override
  _PrueferCodeTaskScreenState createState() => _PrueferCodeTaskScreenState();
}

class _PrueferCodeTaskScreenState extends State<PrueferCodeTaskScreen> {
  TextEditingController controller = TextEditingController();
  String correctAnswer = "";

  @override
  void initState() {
    super.initState();
    correctAnswer =
        PrueferCodeGenerator.generatePrueferCodeAsString(widget.graph.graph);
  }

  void checkAnswer() {
    String userInput = controller.text.trim();
    bool isCorrect = userInput == correctAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        print(correctAnswer);
        return DefaultDialog(
          context: context,
          colorButton: isCorrect ? AppColors.green : AppColors.redBackground,
          mainText: isCorrect ? "Успех" : "Неудача",
          infoText:
              isCorrect ? "Вы успешно решили задачу" : "Повторите попытку",
          buttonText: "Начать заново",
          onPressedFunction: () {
            Navigator.of(context).pop(); // Закрыть диалоговое окно
            controller.clear(); // Очистить поле ввода
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
              "Вычислите код Прюфера для заданного графа"),
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
