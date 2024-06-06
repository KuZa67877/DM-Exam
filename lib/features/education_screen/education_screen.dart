import 'package:dmiti_project/core/algorithms/graph_tree/BinaryTree.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightFlow.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightPath.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/NonBinaryTree.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/UndirectedSmallGraph.dart';
import 'package:dmiti_project/core/algorithms/task_interface.dart';
import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/algorithms/quick_pow_classes.dart';
import 'package:dmiti_project/core/algorithms/transfer_num_system_classes.dart';
import 'package:dmiti_project/core/algorithms/horner_classes.dart';
import 'package:dmiti_project/core/drop_down_menu.dart';
import 'package:dmiti_project/core/full_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_dfs_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_prufer_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_weight_flow_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_weight_path_task.dart';
import 'package:dmiti_project/features/education_screen/info_about_program.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  var showWidgets = List<bool>.filled(17, false); // Увеличение размера списка

  var theme = getTheme();

  void updateWidgets(String item) {
    setState(() {
      for (var i = 0; i < 17; i++) {
        // Обновление для нового размера списка
        showWidgets[i] = item == getTaskName(i);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      showWidgets[0] = true; // Установка первого виджета как активного
    });
  }

  String getTaskName(int index) {
    switch (index) {
      case 0:
        return "Информация";
      case 1:
        return AppStrings.diofantLittle;
      case 2:
        return AppStrings.inverseElevent;
      case 3:
        return AppStrings.nod;
      case 4:
        return AppStrings.continuedFraction;
      case 5:
        return AppStrings.suitableFraction;
      case 6:
        return AppStrings.diafantBig;
      case 7:
        return AppStrings.numSystems;
      case 8:
        return AppStrings.quickPow;
      case 9:
        return AppStrings.bezu;
      case 10:
        return AppStrings.horner;
      case 11:
        return "Диаметр графа";
      case 12:
        return "Код Прюфера";
      case 13:
        return "Bfs";
      case 14:
        return "Dfs";
      case 15:
        return "Максимальный поток";
      case 16:
        return "Кратчайший путь";
      default:
        return AppStrings.horner;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<Task> generateTask() async {
      await Future.delayed(Duration(milliseconds: 100));
      return AxBy1();
    }

    Task task = AxBy1();

    bool setTask(int index) {
      task = getTaskGenerator(index);
      return true;
    }

    void _checkAnswer(bool isCorrect) {}

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 252, 254),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 250, 252, 254),
          title: SizedBox(
            child: Column(
              children: [
                Center(
                  child: Text(
                    AppStrings.education,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: DropDownMenuButton(
                updateWidgets: updateWidgets,
                list: const [
                  "Информация",
                  AppStrings.diofantLittle,
                  AppStrings.inverseElevent,
                  AppStrings.nod,
                  AppStrings.continuedFraction,
                  AppStrings.suitableFraction,
                  AppStrings.diafantBig,
                  AppStrings.numSystems,
                  AppStrings.quickPow,
                  AppStrings.bezu,
                  AppStrings.horner,
                  "Диаметр графа",
                  "Код Прюфера",
                  "Bfs",
                  "Dfs",
                  "Максимальный поток",
                  "Кратчайший путь"
                ],
                isInfo: true,
              ),
            ),
          ),
          if (showWidgets[0])
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: MainInfo(),
            ),
          for (var i = 1; i < 17; i++)
            if (showWidgets[i])
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: i > 10
                    ? i == 11
                        ? GraphTask(
                            myTree: NonBinaryTree(),
                            isEducation: true,
                          )
                        : i == 12
                            ? PrueferCodeTaskScreen(
                                myTree: NonBinaryTree(),
                                isEducation: true,
                              )
                            : i == 13
                                ? DfsBfsTraversalTaskScreen(
                                    tree: BinaryTree(),
                                    isDfs: false,
                                    isEducation: true)
                                : i == 14
                                    ? DfsBfsTraversalTaskScreen(
                                        tree: BinaryTree(),
                                        isDfs: true,
                                        isEducation: true)
                                    : i == 15
                                        ? GraphWeightFlowTask(
                                            isEducation: true,
                                            myGraph: GraphWeightFlow(),
                                          )
                                        : GraphWeightPathTask(
                                            isEducation: true,
                                            myGraph: GraphWeightPath(),
                                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text(
                                AppStrings.solvedTaskTemplate,
                                textAlign: TextAlign.left,
                                style: getTheme().textTheme.bodyLarge,
                              ),
                            ),
                            FullTask(
                              isSolved: false,
                              taskGenerator: getTaskGenerator(i),
                              isEducation: false,
                              isExample: true,
                              onAnswer: _checkAnswer,
                            ),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: 8.0),
                                child:
                                    formatTaskText(task.generateInstruction()))
                          ],
                        ),
                      ),
              )
        ],
      ),
    );
  }
}

Task getTaskGenerator(int index) {
  switch (index) {
    case 1:
      return AxBy1();
    case 2:
      return InverseNumber();
    case 3:
      return NOD();
    case 4:
      return ContinuedFraction();
    case 5:
      return SuitableFractions();
    case 6:
      return Diafant();
    case 7:
      return TransferNumSystem();
    case 8:
      return QuickPow();
    case 9:
      return HornerRoot();
    case 10:
      return HornerPoly();
    case 11:
      return HornerPoly();
    case 12:
      return HornerPoly();
    case 13:
      return HornerPoly();
    case 14:
      return HornerPoly();
    case 15:
      return HornerPoly();
    case 16:
      return HornerPoly();
    default:
      return AxBy1();
  }
}

Column formatTaskText(List<String> instructions) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < instructions.length; i++)
        (instructions[i][0] == "#")
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  instructions[i].substring(2),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "WorkSans",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Text(
                  instructions[i],
                  textAlign: TextAlign.left,
                  style: getTheme().textTheme.bodyLarge,
                ),
              ),
    ],
  );
}
