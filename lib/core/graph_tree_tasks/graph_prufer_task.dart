import 'package:flutter/material.dart';
import 'package:dmiti_project/core/alert_dialog.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/NonBinaryTree.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/core/graph_tree_vizualize/tree_visualizer.dart';
import 'package:dmiti_project/core/textfield/graph_textfield.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:dmiti_project/res/colors.dart';

class PrueferCodeTaskScreen extends StatefulWidget {
  final NonBinaryTree myTree;
  final bool isEducation;

  PrueferCodeTaskScreen(
      {Key? key, required this.myTree, required this.isEducation})
      : super(key: key);

  @override
  _PrueferCodeTaskScreenState createState() => _PrueferCodeTaskScreenState();
}

class _PrueferCodeTaskScreenState extends State<PrueferCodeTaskScreen> {
  TextEditingController controller = TextEditingController();
  String correctAnswer = "";
  List<String> steps = [];
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    widget.myTree.fill_tree();

    if (widget.myTree.head != null) {
      correctAnswer = widget.myTree.generatePruferCode();
      if (widget.isEducation) {
        steps = widget.myTree.generatePruferCodeSteps();
      }
      print(widget.myTree.calculateTreeProperties());
      print(correctAnswer);
    } else {
      correctAnswer = "";
      print("Ошибка: дерево пустое.");
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
        print(correctAnswer);
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
              "Вычислите код Прюфера для заданного дерева",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (widget.isEducation) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Код Прюфера представляет собой последовательность номеров вершин, образованную в результате последовательного удаления листьев из дерева.",
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
              SizedBox(height: 20),
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
