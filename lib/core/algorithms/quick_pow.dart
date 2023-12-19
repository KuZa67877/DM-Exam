import 'dart:math';

import 'package:dmiti_project/core/algorithms/evklid_classes.dart';

class QuickPow extends Task {
  late int num;
  late int power;

  QuickPow() {
    data = generateVariant();
    firstline = data[0];
    secondline = data[1];
    thirdline = [];
    fourthLine = [];
    linesCount = 2;
  }

  @override
  List<List<int>> generateVariant() {
    num = 2 + Random().nextInt(2);
    int power_limit;
    (num > 2) ? (power_limit = 10) : (power_limit = 15);
    power = 5 + Random().nextInt(power_limit);
    List<List<int>> result = quick_pow(num, power);
    return result;
  }

  @override
  String writeQuestion() {
    String question = "Возведите $num в степень $power";
    return question;
  }

  List<List<int>> quick_pow(int a, int deg) {
    String binary_deg = deg.toRadixString(2);
    List<int> binary_deg1 =
        binary_deg.split('').map((e) => int.parse(e)).toList();

    List<int> values = [];
    List<int> degrees = [];
    int res = 1;
    int temp_deg = 0;
    for (int i = 0; i < binary_deg.length; i++) {
      if (binary_deg[i] == "1") {
        temp_deg = temp_deg * 2 + 1;
        res *= res;
        res *= a;
        values.add(res);
        degrees.add(temp_deg);
      } else {
        temp_deg = temp_deg * 2;
        res *= res;
        values.add(res);
        degrees.add(temp_deg);
      }
    }
    return [binary_deg1, values];
  }
}
