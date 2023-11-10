import 'package:dmiti_project/trainingScreens/continued_fraction.dart';
import 'package:flutter/material.dart';

import 'EducationScreen.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({Key? key}) : super(key: key);

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  var showWidgetOne = true;
  var showWidgetTwo = false;
  var showWidgetThree = false;

  void updateWidgets(String item) {
    setState(() {
      showWidgetOne = item == 'One';
      showWidgetTwo = item == 'Two';
      showWidgetThree = item == 'Three';
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
              children: const [
                Center(
                  child: Text(
                    "Обучение",
                    style: TextStyle(
                      color: Color.fromARGB(255, 36, 36, 63),
                      fontFamily: 'WorkSans',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
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
              child: DropDownMenuButton(
                updateWidgets: updateWidgets,
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          if (showWidgetOne)
            Positioned(
              child: continuedFractionScreen(),
              top: 50,
            ),
          if (showWidgetTwo) Info2(),
          if (showWidgetThree) Info3(),
          //Center(child: FieldExample()),
        ],
      ),
    );
  }
}
