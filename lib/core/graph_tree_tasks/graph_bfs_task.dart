import 'package:dmiti_project/core/algorithms/graph_tree/BinaryTree.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphAnalysis.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/tree_visualizer.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/graph_visualizer.dart';
import 'package:dmiti_project/res/colors.dart';

class BfsTraversalTaskScreen extends StatefulWidget {
  final BinaryTree tree;
  final bool isEducation;

  BfsTraversalTaskScreen(
      {Key? key, required this.tree, required this.isEducation})
      : super(key: key);

  @override
  _BfsTraversalTaskScreenState createState() => _BfsTraversalTaskScreenState();
}

class _BfsTraversalTaskScreenState extends State<BfsTraversalTaskScreen> {
  TextEditingController controller = TextEditingController();
  late String correctAnswer;
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    widget.tree.fill_tree();
    correctAnswer = widget.tree.bfs(widget.tree.head);
    if (widget.isEducation) {
      steps = widget.tree.bfs_steps(widget.tree.head);
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
    String userInput = controller.text.trim();
    bool isCorrect = userInput == correctAnswer;
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
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            children: [
              if (widget.isEducation) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Метод обхода в ширину (BFS) заключается в посещении каждого уровня дерева по очереди, начиная с корня.",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                ),
              ],
              Center(
                child: Container(
                  height: 250,
                  width: 200,
                  child: TreePainterWidget(tree: widget.tree),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "Выполните обход графа в ширину (BFS)",
                  style: getTheme().textTheme.bodyLarge,
                ),
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
