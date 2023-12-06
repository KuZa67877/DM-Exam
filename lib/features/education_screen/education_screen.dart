import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/core/drop_down_menu.dart';
import 'package:dmiti_project/core/full_task.dart';
import 'package:dmiti_project/features/education_screen/info_about_program.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationScreen extends StatefulWidget {
  //TODO заблокировать нажатие кнопки, ну или сделать отсутствие кликабельности
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  var showInfo = true;
  var showWidgetOne = false;
  var showWidgetTwo = false;
  var showWidgetThree = false;
  var showWidgetFour = false;
  var showWidgetFive = false;
  var showWidgetSix = false;
  var theme = getTheme();

  void updateWidgets(String item) {
    setState(() {
      showInfo = item == "Информация";
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
    Future<Task> generateTask() async {
      // Замените это на вашу логику генерации задачи
      await Future.delayed(Duration(milliseconds: 100));
      return AxBy1();
    }

    int _correctAnswers = 0;
    void _checkAnswer(bool isCorrect) {
      if (isCorrect) {
        _correctAnswers++;
      } //TODO эту временную хуйню потом убрать, прям чувствую себя костылекреейтером
      //_nextTask();
    }

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
          if (showInfo)
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: MainInfo(),
            ),
          if (showWidgetOne)
            Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Container(
                          width: 300,
                          child: Text(
                              "Верный вариант ввода задачи выглядит следующим образом:",
                              style: getTheme().textTheme.bodyLarge),
                        ),
                      ),
                      FutureBuilder<Task>(
                        future: generateTask(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Task> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              taskInfo: AppStrings.diofantLittleTask,
                              isExample: true,
                              onAnswer: null,
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Container(
                          width: 300,
                          child: Text(
                              "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                              style: getTheme().textTheme.bodyLarge),
                        ),
                      ),
                    ],
                  ),
                )),
          if (showWidgetTwo)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Верный вариант ввода задачи выглядит следующим образом:",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                    FullTask(
                      isSolved: false,
                      taskGenerator: InverseNumber(),
                      taskInfo: AppStrings.inverseNumberTask,
                      isExample: true, //поменять, лишняя строка
                      onAnswer: _checkAnswer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (showWidgetThree)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Верный вариант ввода задачи выглядит следующим образом:",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                    FullTask(
                      isSolved: false,
                      taskGenerator: NOD(),
                      taskInfo: AppStrings.inverseNumberTask,
                      isExample: true, //поменять, лишняя строка
                      onAnswer: _checkAnswer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (showWidgetFour)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Верный вариант ввода задачи выглядит следующим образом:",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                    FullTask(
                      isSolved: false,
                      taskGenerator: ContinuedFraction(),
                      taskInfo: AppStrings.inverseNumberTask,
                      isExample: true, //поменять, лишняя строка
                      onAnswer: _checkAnswer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (showWidgetFive)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Верный вариант ввода задачи выглядит следующим образом:",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                    FullTask(
                      isSolved: false,
                      taskGenerator: SuitableFractions(),
                      taskInfo: AppStrings.inverseNumberTask,
                      isExample: true, //поменять, лишняя строка
                      onAnswer: _checkAnswer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (showWidgetSix)
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Верный вариант ввода задачи выглядит следующим образом:",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                    FullTask(
                      isSolved: false,
                      taskGenerator: Diafant(),
                      taskInfo: AppStrings.inverseNumberTask,
                      isExample: true, //поменять, лишняя строка
                      onAnswer: _checkAnswer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        width: 300,
                        child: Text(
                            "Таблица заполняется по аналогии с алгоритмом Евклида (Как? См. раздел Информация)",
                            style: getTheme().textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
