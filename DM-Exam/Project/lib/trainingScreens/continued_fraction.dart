import 'package:dmiti_project/EducationScreen.dart';
import 'package:dmiti_project/algorithms/evklid_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';

class continuedFractionScreen extends StatefulWidget {
  const continuedFractionScreen({super.key});

  @override
  State<continuedFractionScreen> createState() =>
      _continuedFractionScreenState();
}

class _continuedFractionScreenState extends State<continuedFractionScreen> {
  Cepnaya result = Cepnaya();
  late var x = result.x_condition;
  late var y = result.y_condition;
  late var len = result.line1.length;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    print(len);
    for (int i = 0; i < len; i++) {
      widgets.add(FieldExample());
    }
    return Column(
      children: [
        Center(
          child: Row(
            children: [
              Text("Найдите подходящие дроби для"),
              Column(
                children: [
                  Text("$x"),
                  Container(
                    width: 25,
                    height: 25,
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  Text("$y")
                ],
              ),
            ],
          ),
        ),
        FieldExample()
      ],
    );
  }
}
