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
  final bool isEducation;
  const GraphTask({super.key, required this.myTree, required this.isEducation});

  @override
  State<GraphTask> createState() => _GraphTaskState();
}

class _GraphTaskState extends State<GraphTask> {
  TextEditingController controller = TextEditingController();
  String correctAnswer = ""; // Переменная для хранения правильного ответа
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    // Рассчитываем правильные значения для радиуса, диаметра и центра графа
    widget.myTree.generate_tree();
    var analysis = widget.myTree.calculateTreeProperties();
    String centers = (analysis['centers'] as List).join(', ');
    correctAnswer = "${analysis['radius']} ${analysis['diameter']} $centers";

    if (widget.isEducation) {
      steps = widget.myTree.calculateTreePropertiesSteps();
    }

    print(correctAnswer);
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
    String userInput =
        controller.text.trim(); // Получаем введенный пользователем текст
    List<String> answers = correctAnswer
        .split(" ")
        .map((e) => e.trim())
        .toList(); // Разбиваем строку на отдельные ответы
    bool isCorrect = true; // Предполагаем, что ответ верный

    // Проверяем, что введено столько же значений, сколько требуется
    if (answers.length != userInput.split(" ").length) {
      isCorrect = false; // Если введено меньше значений, считаем ответ неверным
    } else {
      // Сравниваем введенные данные с правильными
      for (int i = 0; i < answers.length; i++) {
        String userInputPart =
            userInput.split(" ")[i].trim(); // Получаем часть введенного ответа
        String correctAnswerPart =
            answers[i]; // Получаем соответствующую часть правильного ответа

        // Проверяем, что введенное значение является числом или совпадает с названием центра
        if (correctAnswerPart == "Центр") {
          if (userInputPart != correctAnswerPart) {
            isCorrect = false;
          }
        } else {
          if (userInputPart.isNotEmpty &&
              RegExp(r'^\d+$').hasMatch(userInputPart)) {
            if (int.parse(userInputPart) != int.parse(correctAnswerPart)) {
              isCorrect = false;
            }
          } else {
            isCorrect = false; // Если введено не число, считаем ответ неверным
          }
        }
      }
    }

    // Показываем результат в диалоговом окне
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
            Navigator.of(context).pop(); // Закрыть диалоговое окно
            controller.clear(); // Очистить поле ввода
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
            if (widget.isEducation) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "В графовой теории диаметр графа - это максимальное расстояние между всеми парами вершин в графе. Радиус графа - это минимальное расстояние от одной вершины графа до самой удаленной от нее вершины в графе. Центр графа - это множество вершин графа, имеющих минимальный эксцентриситет.",
                  style: getTheme().textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
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
                    SizedBox(
                      width: 15,
                    ),
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
            if (!widget.isEducation) ...[
              GraphTextField(
                controller: controller,
                isEducation: widget.isEducation,
                answer: correctAnswer,
              ),
              SizedBox(height: 20),
              DefaultButton(
                info: "Отправить",
                buttonColor: AppColors.green,
                onPressedFunction: checkAnswer,
                isSettings: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
