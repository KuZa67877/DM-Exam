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

  @override
  void initState() {
    super.initState();
    // Рассчитываем правильные значения для радиуса, диаметра и центра графа
    widget.myTree.generate_tree();
    var analysis = widget.myTree.calculateTreeProperties();
    String centers = (analysis['centers'] as List).join(', ');
    correctAnswer = "${analysis['radius']} ${analysis['diameter']} $centers";
    print(correctAnswer);
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
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: 200,
                  child: TreePainterWidget(tree: widget.myTree),
                ),
              ),
              Text(
                "Найдите диаметр, радиус и центр данного графа",
                style: getTheme().textTheme.bodyLarge,
              ),
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
        },
      ),
    );
  }
}
