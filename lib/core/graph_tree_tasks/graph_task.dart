import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphAnalysis.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/NonBinaryTree.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_visualizer.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/tree_visualizer.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GraphTask extends StatefulWidget {
  final NonBinaryTree myTree;
  final bool isStudy;
  final bool isEducation;
  const GraphTask({
    super.key,
    required this.myTree,
    required this.isStudy,
    required this.isEducation,
  });

  @override
  State<GraphTask> createState() => _GraphTaskState();
}

class _GraphTaskState extends State<GraphTask> {
  TextEditingController radiusController = TextEditingController();
  TextEditingController diameterController = TextEditingController();
  TextEditingController centerController = TextEditingController();

  String correctRadius = "";
  String correctDiameter = "";
  String correctCenters = "";
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    widget.myTree.generate_tree();
    var analysis = widget.myTree.calculateTreeProperties();
    correctRadius = analysis['radius'].toString().trim();
    correctDiameter = analysis['diameter'].toString().trim();
    correctCenters = (analysis['centers'] as List)
        .map((e) => e.toString().trim())
        .join(', ');

    if (widget.isEducation) {
      steps = widget.myTree.calculateTreePropertiesSteps();
    }

    print("$correctRadius $correctDiameter $correctCenters");
    print(centerController.text.trim());
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void checkAnswer() {
    String userRadius = radiusController.text.trim();
    String userDiameter = diameterController.text.trim();
    String userCenters = centerController.text.trim();

    // Убедитесь, что значения правильно форматированы
    print(
        "$userRadius - $correctRadius   $userDiameter - $correctDiameter    $userCenters - $correctCenters");
    print(userRadius == correctRadius);
    print(userDiameter == correctDiameter);
    print(userCenters == correctCenters);

    // Преобразуем строки центров в списки и убираем пробелы
    Set<String> userCentersSet =
        userCenters.split(',').map((e) => e.trim()).toSet();
    Set<String> correctCentersSet =
        correctCenters.split(',').map((e) => e.trim()).toSet();

    // Проверяем совпадение
    bool isCorrect = userRadius == correctRadius &&
        userDiameter == correctDiameter &&
        userCenters == correctCenters;

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
            radiusController.clear();
            diameterController.clear();
            centerController.clear();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.isEducation)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Диаметр - максимальная длина (в рёбрах) кратчайшего пути в дереве между любыми двумя вершинами. Эксцентриситет - расстояние до самой дальней вершины графа. Радиус - это наименьший из эксцентриситетов вершин.",
                  style: getTheme().textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            Center(
              child: Container(
                height: 250,
                width: 200,
                child: TreePainterWidget(tree: widget.myTree),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Найдите диаметр, радиус и центр данного графа",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Радиус",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            GraphTextField(
              isStudy: widget.isStudy,
              controller: radiusController,
              isEducation: widget.isEducation,
              answer: correctRadius,
            ),
            SizedBox(height: 20),
            Text(
              "Диаметр",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            GraphTextField(
              isStudy: widget.isStudy,
              controller: diameterController,
              isEducation: widget.isEducation,
              answer: correctDiameter,
            ),
            SizedBox(height: 20),
            Text(
              "Центр",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            GraphTextField(
              isStudy: widget.isStudy,
              controller: centerController,
              isEducation: widget.isEducation,
              answer: correctCenters,
            ),
            SizedBox(height: 20),
            DefaultButton(
              info: "Отправить",
              buttonColor: AppColors.green,
              onPressedFunction: checkAnswer,
              isSettings: false,
            ),
            if (widget.isEducation) ...[
              SizedBox(height: 20),
              Text(
                "Пошаговая демонстрация нахождения решения:",
                style: getTheme().textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              Text(
                steps[currentStep],
                style: getTheme().textTheme.bodyLarge,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                      info: "Предыдущий шаг",
                      buttonColor: AppColors.green,
                      onPressedFunction: previousStep,
                      isSettings: false,
                    ),
                    SizedBox(width: 15),
                    DefaultButton(
                      info: "Следующий шаг",
                      buttonColor: AppColors.green,
                      onPressedFunction: nextStep,
                      isSettings: false,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
