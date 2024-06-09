import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightFlow.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_weight_vizualizer.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class GraphWeightFlowTask extends StatefulWidget {
  final GraphWeightFlow myGraph;
  final bool isEducation;
  const GraphWeightFlowTask(
      {super.key, required this.myGraph, required this.isEducation});

  @override
  State<GraphWeightFlowTask> createState() => _GraphWeightFlowTaskState();
}

class _GraphWeightFlowTaskState extends State<GraphWeightFlowTask> {
  TextEditingController controller = TextEditingController();
  String correctAnswer = "";
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    correctAnswer = widget.myGraph.ford_fulkerson().toString();
    if (widget.isEducation) {
      steps = widget.myGraph.ford_fulkerson_steps();
    }
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
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            children: [
              if (widget.isEducation) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Метод Форда-Фалкерсона заключается в следующем:\n"
                    "1. Начинаем с нулевого потока.\n"
                    "2. Находим путь от истока к стоку, вдоль которого еще можно увеличить поток.\n"
                    "3. Увеличиваем поток по этому пути на возможную величину.\n"
                    "4. Повторяем шаги 2 и 3, пока не удается найти путь для увеличения потока.\n"
                    "На каждом шагу отображается текущий найденный поток, путь, по которому он идет, и текущий максимальный поток.",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                ),
              ],
              Center(
                child: Container(
                  height: 250,
                  width: 200,
                  child: GraphWeightWidget(
                    graphGenerator: widget.myGraph,
                  ),
                ),
              ),
              Text(
                "Найдите максимальный поток для этого графа",
                style: getTheme().textTheme.bodyLarge,
              ),
              if (widget.isEducation) ...[
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
                  onPressedFunction: checkAnswer,
                  isSettings: false,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
