import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightFlow.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_weight_vizualizer.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class GraphWeightFlowTask extends StatefulWidget {
  final bool isStudy;
  final GraphWeightFlow myGraph;
  final bool isEducation;
  const GraphWeightFlowTask(
      {super.key,
      required this.myGraph,
      required this.isEducation,
      required this.isStudy});

  @override
  State<GraphWeightFlowTask> createState() => _GraphWeightFlowTaskState();
}

class _GraphWeightFlowTaskState extends State<GraphWeightFlowTask> {
  TextEditingController controller = TextEditingController();
  String correctAnswerFordFulkerson = "";
  String correctAnswerEdmondsKarp = "";
  List<String> stepsFordFulkerson = [];
  List<String> stepsEdmondsKarp = [];
  int currentStepFordFulkerson = 0;
  int currentStepEdmondsKarp = 0;

  @override
  void initState() {
    super.initState();
    correctAnswerFordFulkerson = widget.myGraph.ford_fulkerson().toString();
    correctAnswerEdmondsKarp = widget.myGraph.edmonds_karp().toString();
    if (widget.isEducation) {
      stepsFordFulkerson = widget.myGraph.ford_fulkerson_steps();
      stepsEdmondsKarp = widget.myGraph.edmonds_karp_steps();
    }
  }

  void nextStepFordFulkerson() {
    if (currentStepFordFulkerson < stepsFordFulkerson.length - 1) {
      setState(() {
        currentStepFordFulkerson++;
      });
    }
  }

  void previousStepFordFulkerson() {
    if (currentStepFordFulkerson > 0) {
      setState(() {
        currentStepFordFulkerson--;
      });
    }
  }

  void nextStepEdmondsKarp() {
    if (currentStepEdmondsKarp < stepsEdmondsKarp.length - 1) {
      setState(() {
        currentStepEdmondsKarp++;
      });
    }
  }

  void previousStepEdmondsKarp() {
    if (currentStepEdmondsKarp > 0) {
      setState(() {
        currentStepEdmondsKarp--;
      });
    }
  }

  void checkAnswer() {
    String userInput = controller.text.trim();
    List<String> answersFordFulkerson =
        correctAnswerFordFulkerson.split(" ").map((e) => e.trim()).toList();
    List<String> answersEdmondsKarp =
        correctAnswerEdmondsKarp.split(" ").map((e) => e.trim()).toList();
    bool isCorrectFordFulkerson =
        checkCorrectness(userInput, answersFordFulkerson);
    bool isCorrectEdmondsKarp = checkCorrectness(userInput, answersEdmondsKarp);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultDialog(
          context: context,
          colorButton: (isCorrectFordFulkerson || isCorrectEdmondsKarp)
              ? AppColors.green
              : AppColors.redBackground,
          mainText: (isCorrectFordFulkerson || isCorrectEdmondsKarp)
              ? "Успех"
              : "Неудача",
          infoText: (isCorrectFordFulkerson || isCorrectEdmondsKarp)
              ? "Вы успешно решили задачу"
              : "Повторите попытку",
          buttonText: "Начать заново",
          onPressedFunction: () {
            Navigator.of(context).pop();
            controller.clear();
          },
        );
      },
    );
  }

  bool checkCorrectness(String userInput, List<String> correctAnswers) {
    List<String> inputs = userInput.split(" ").map((e) => e.trim()).toList();
    if (inputs.length != correctAnswers.length) return false;
    for (int i = 0; i < inputs.length; i++) {
      if (inputs[i] != correctAnswers[i]) return false;
    }
    return true;
  }

  void showFirstStep() {
    if (widget.isEducation) {
      setState(() {
        currentStepFordFulkerson = 0;
      });
    }
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
                  "Пошаговая демонстрация нахождения решения алгоритмом Форда-Фалкерсона:",
                  style: getTheme().textTheme.bodyLarge,
                ),
                Text(
                  stepsFordFulkerson[currentStepFordFulkerson],
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
                        onPressedFunction: previousStepFordFulkerson,
                        isSettings: false,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DefaultButton(
                        info: "Следующий шаг",
                        buttonColor: AppColors.green,
                        onPressedFunction: nextStepFordFulkerson,
                        isSettings: false,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Пошаговая демонстрация нахождения решения алгоритмом Эдмондса-Карпа:",
                  style: getTheme().textTheme.bodyLarge,
                ),
                Text(
                  stepsEdmondsKarp[currentStepEdmondsKarp],
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
                        onPressedFunction: previousStepEdmondsKarp,
                        isSettings: false,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DefaultButton(
                        info: "Следующий шаг",
                        buttonColor: AppColors.green,
                        onPressedFunction: nextStepEdmondsKarp,
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
                    isStudy: widget.isStudy,
                    controller: controller,
                    isEducation: widget.isEducation,
                    answer:
                        "$correctAnswerFordFulkerson $correctAnswerEdmondsKarp",
                  ),
                ),
                DefaultButton(
                  info: "Отправить",
                  buttonColor: AppColors.green,
                  onPressedFunction: checkAnswer,
                  isSettings: false,
                ),
              ],
              // if (widget.isStudy) ...[
              //   Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: GestureDetector(
              //       onTap: showFirstStep,
              //       child: Text(
              //         "Нажмите здесь, чтобы увидеть первый шаг решения",
              //         style: TextStyle(
              //           color: AppColors.black,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
            ],
          );
        },
      ),
    );
  }
}
