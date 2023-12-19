import 'task_interface.dart';
import 'dart:math';

class QuickPow extends Task {
  late int num;
  late int power;

  QuickPow() {
    data = generateVariant();
    lines = data;
    linesCount = 2;
  }

  @override
  List<List<int>> generateVariant() {
    num = 2 + Random().nextInt(2);
    (num > 2)
        ? (power = 4 + Random().nextInt(6))
        : (power = 7 + Random().nextInt(8));
    List<List<int>> result = quick_pow(num, power);
    return result;
  }

  @override
  String writeQuestion() {
    String question = "Возведите $num в степень $power";
    return question;
  }

  List<List<int>> quick_pow(int a, int deg) {
    List<String> binary_str = deg.toRadixString(2).split('');
    List<int> binary_deg = binary_str.map((str) => int.parse(str)).toList();
    List<int> values = [];
    List<int> degrees = [];
    int res = 1;
    int temp_deg = 0;
    for (int i = 0; i < binary_deg.length; i++) {
      if (binary_deg[i] == 1) {
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
    return [binary_deg, values];
  }
}
