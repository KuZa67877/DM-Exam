import 'package:dmiti_project/core/drop_down_menu.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  var theme = getTheme();
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
          //if (showWidgetOne) Info1(),
          if (showWidgetTwo) Info2(),
          if (showWidgetThree) Info3(),
          //Center(child: FieldExample()),
          const Center(
            child: Row(
              children: [
                // FieldExample(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Info2 extends StatelessWidget {
  Info2({Key? key}) : super(key: key);
  final theme = getTheme();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 267,
        height: 365,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20),
          child: Text(
            AppStrings.euclid,
            style: theme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

class Info3 extends StatelessWidget {
  const Info3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 267,
        height: 365,
        color: Colors.red,
      ),
    );
  }
}
