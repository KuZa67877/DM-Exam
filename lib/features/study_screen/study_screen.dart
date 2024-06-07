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
import 'package:dmiti_project/core/graph_tree_tasks/graph_prufer_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_task.dart';
import 'package:dmiti_project/core/graph_tree_tasks/graph_weight_path_task.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

import '../../core/graph_tree_tasks/graph_dfs_task.dart';
import '../../core/graph_tree_tasks/graph_weight_flow_task.dart'; // Импортируем GraphWeightFlowTask

class StudyScreen extends StatefulWidget {
  final bool isEducation;
  final String title;
  const StudyScreen({Key? key, required this.isEducation, required this.title})
      : super(key: key);

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  Future<Task> generateTask() async {
    await Future.delayed(Duration(milliseconds: 10));
    return AxBy1();
  }

  List<bool> showWidgets = List<bool>.filled(16, false); // Увеличиваем до 15
  @override
  void initState() {
    super.initState();
    setState(() {
      showWidgets[0] = true;
    });
  }

  var theme = getTheme();

  void updateWidgets(String item) {
    setState(() {
      for (var i = 0; i < 16; i++) {
        // Увеличиваем до 15
        showWidgets[i] = item == getTaskName(i);
      }
    });
  }

  String getTaskName(int index) {
    switch (index) {
      case 0:
        return AppStrings.diofantLittle;
      case 1:
        return AppStrings.inverseElevent;
      case 2:
        return AppStrings.nod;
      case 3:
        return AppStrings.continuedFraction;
      case 4:
        return AppStrings.suitableFraction;
      case 5:
        return AppStrings.diafantBig;
      case 6:
        return AppStrings.numSystems;
      case 7:
        return AppStrings.quickPow;
      case 8:
        return AppStrings.bezu;
      case 9:
        return AppStrings.horner;
      case 10:
        return "Диаметр графа";
      case 11:
        return "Код Прюфера";
      case 12:
        return "Dfs";
      case 13:
        return "Bfs";
      case 14:
        return "Максимальный поток"; // Добавляем новый элемент
      case 15:
        return "Кратчайший путь";
      default:
        return AppStrings.horner;
    }
  }

  Task getTaskGenerator(int index) {
    switch (index) {
      case 0:
        return AxBy1();
      case 1:
        return InverseNumber();
      case 2:
        return NOD();
      case 3:
        return ContinuedFraction();
      case 4:
        return SuitableFractions();
      case 5:
        return Diafant();
      case 6:
        return TransferNumSystem();
      case 7:
        return QuickPow();
      case 8:
        return HornerRoot();
      case 9:
        return HornerPoly();
      case 10:
        return HornerPoly();
      case 11:
        return HornerPoly();
      case 12:
        return HornerPoly();
      case 13:
        return HornerPoly();
      case 14:
        return HornerPoly(); // Возвращаем GraphWeightFlow для максимального потока
      case 15:
        return HornerPoly();
      default:
        return HornerPoly();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.title,
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
                  "Кратчайший путь" // Добавляем новый элемент
                ],
                isInfo: false,
              ),
            ),
          ),
          for (var i = 0; i < 16; i++) // Увеличиваем размер до 15
            if (showWidgets[i])
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: i >= 10
                    ? i == 10
                        ? GraphTask(
                            myTree: NonBinaryTree(),
                            isEducation: false,
                          )
                        : i == 11
                            ? PrueferCodeTaskScreen(
                                myTree: NonBinaryTree(),
                                isEducation: false,
                              )
                            : i == 12
                                ? DfsTraversalTaskScreen(
                                    tree: BinaryTree(),
                                    isDfs: true,
                                    isEducation: false)
                                : i == 13
                                    ? DfsTraversalTaskScreen(
                                        tree: BinaryTree(),
                                        isDfs: false,
                                        isEducation: false)
                                    : i == 14
                                        ? GraphWeightFlowTask(
                                            isEducation: false,
                                            myGraph: GraphWeightFlow(),
                                          )
                                        : GraphWeightPathTask(
                                            isEducation: false,
                                            myGraph: GraphWeightPath(),
                                          ) // Добавляем новый виджет
                    : FullTask(
                        isSolved: false,
                        taskGenerator: getTaskGenerator(i),
                        isExample: false,
                        onAnswer: null,
                        isEducation: widget.isEducation),
              ),
        ],
      ),
    );
  }
}
