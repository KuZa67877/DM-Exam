import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/algorithms/quick_pow.dart';
import 'package:dmiti_project/core/algorithms/transfer_num_system.dart';
import 'package:dmiti_project/core/drop_down_menu.dart';
import 'package:dmiti_project/core/full_task.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

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
    // Замените это на вашу логику генерации задачи
    await Future.delayed(Duration(milliseconds: 10));
    return AxBy1();
  }

  var showWidgetOne = true;
  var showWidgetTwo = false;
  var showWidgetThree = false;
  var showWidgetFour = false;
  var showWidgetFive = false;
  var showWidgetSix = false;
  var showWidgetSeven = false;
  var showWidgetEight = false;
  var theme = getTheme();

  void updateWidgets(String item) {
    setState(() {
      showWidgetOne = item == AppStrings.diofantLittle;
      showWidgetTwo = item == AppStrings.inverseElevent;
      showWidgetThree = item == AppStrings.nod;
      showWidgetFour = item == AppStrings.continuedFraction;
      showWidgetFive = item == AppStrings.suitableFraction;
      showWidgetSix = item == AppStrings.diafantBig;
      showWidgetSeven = item == "Перевод в другую СС";
      showWidgetEight = item == "Возведение в степень";
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
                  "Перевод в другую СС",
                  "Возведение в степень"
                ],
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 330),
          //   child: HelpButton(),
          // ),
          if (showWidgetOne)
            //var generator = AxBy1();
            Padding(
                padding: EdgeInsets.only(top: 120),
                child: FutureBuilder<Task>(
                  future: generateTask(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Task> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.green,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return FullTask(
                        isSolved: false,
                        taskGenerator: snapshot.data!,
                        isExample: false,
                        onAnswer: null,
                        isEducation: widget.isEducation,
                      );
                    }
                  },
                )),
          if (showWidgetTwo)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: InverseNumber(),
                //поменять, лишняя строка
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetThree)
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: FullTask(
                isSolved: false,
                taskGenerator: NOD(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetFour)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: ContinuedFraction(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetFive)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: SuitableFractions(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetSix)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: Diafant(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetSeven)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: TransferNumSystem(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
          if (showWidgetEight)
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: FullTask(
                isSolved: false,
                taskGenerator: QuickPow(),
                isExample: false,
                onAnswer: null,
                isEducation: widget.isEducation,
              ),
            ),
        ],
      ),
    );
  }
}
