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

class DfsTraversalTaskScreen extends StatefulWidget {
  final BinaryTree tree;
  final bool isDfs;
  final bool isEducation;

  DfsTraversalTaskScreen(
      {Key? key,
      required this.tree,
      required this.isDfs,
      required this.isEducation})
      : super(key: key);

  @override
  _DfsTraversalTaskScreenState createState() => _DfsTraversalTaskScreenState();
}

class _DfsTraversalTaskScreenState extends State<DfsTraversalTaskScreen> {
  TextEditingController controller = TextEditingController();
  late String correctAnswer;

  @override
  void initState() {
    super.initState();
    if (widget.isDfs) {
      widget.tree.fill_tree(); // Добавляем заполнение дерева перед обходом
      correctAnswer = widget.tree.dfs(widget.tree.head);
    } else {
      widget.tree.fill_tree(); // Добавляем заполнение дерева перед обходом
      correctAnswer = widget.tree.bfs(widget.tree.head);
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
    return SingleChildScrollView(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Column(
        children: [
          Center(
            child: Container(
              height: 250,
              width: 200,
              child: TreePainterWidget(tree: widget.tree),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
              style: getTheme().textTheme.bodyLarge,
              widget.isDfs
                  ? "Выполните обход графа в глубину (DFS)"
                  : "Выполните обход графа в ширину (BFS)"),
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
