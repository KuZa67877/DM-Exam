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

  @override
  void initState() {
    super.initState();
    widget.myTree.fill_tree();

    if (widget.myTree.head != null) {
      correctAnswer = widget.myTree.generatePruferCode();
      print(widget.myTree.calculateTreeProperties());
      print(correctAnswer);
    } else {
      correctAnswer = "";
      print("Ошибка: дерево пустое.");
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
            SizedBox(height: 200),
            Text(
              "Вычислите код Прюфера для заданного дерева",
              style: getTheme().textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
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
              onPressedFunction: widget.isEducation ? () {} : checkAnswer,
              isSettings: false,
            ),
          ],
        ),
      ),
    );
  }
}
