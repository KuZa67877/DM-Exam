import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/drop_down_menu.dart';
import 'package:dmiti_project/features/task_screens.dart/full_task.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  var showWidgetOne = true;
  var showWidgetTwo = false;
  var showWidgetThree = false;
  var showWidgetFour = false;
  var showWidgetFive = false;
  var showWidgetSix = false;
  var theme = getTheme();

  void updateWidgets(String item) {
    setState(() {
      showWidgetOne = item == AppStrings.diofantLittle;
      showWidgetTwo = item == AppStrings.inverseElevent;
      showWidgetThree = item == AppStrings.nod;
      showWidgetFour = item == AppStrings.continuedFraction;
      showWidgetFive = item == AppStrings.suitableFraction;
      showWidgetSix = item == AppStrings.diafantBig;
    });
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
                    AppStrings.education,
                    style: theme.textTheme.titleLarge,
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
              ),
            ),
          ),
          if (showWidgetOne)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                  isSolved: false,
                  taskGenerator: AxBy1(),
                  taskInfo: AppStrings.diofantLittleTask),
            ),
          if (showWidgetTwo)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: InverseNumber(),
                taskInfo:
                    AppStrings.inverseNumberTask, //поменять, лишняя строка
              ),
            ),
          if (showWidgetThree)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: NOD(),
                taskInfo: AppStrings.nodTask,
              ),
            ),
          if (showWidgetFour)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: ContinuedFraction(),
                taskInfo: AppStrings.continuedFractionTask,
              ),
            ),
          if (showWidgetFive)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: SuitableFractions(),
                taskInfo: AppStrings.suitableFractionTask,
              ),
            ),
          if (showWidgetSix)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: Diafant(),
                taskInfo: AppStrings.diafantBigTask,
              ),
            ),
        ],
      ),
    );
  }
}
