import 'task_interface.dart';
import 'dart:math';

class QuickPow extends Task {
  late int num;
  late int power;

  QuickPow() {
    data = generateVariant();
  }

  @override
  List<List<int>> generateVariant() {
    num = 2 + Random().nextInt(2);
    int powerLimit;
    (num > 2) ? (powerLimit = 10) : (powerLimit = 15);
    power = 5 + Random().nextInt(powerLimit);
    data = quick_pow(num, power);
    return data;
  }

  @override
  String writeQuestion() {
    String question =
        "Возведите ${num.toString()} в степень ${power.toString()}";
    return question;
  }

  List<List<int>> quick_pow(int a, int deg) {
    var binary_deg = deg.toRadixString(2);
    List deg_bin = binary_deg.split('');
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
    return [degrees, values];
  }
}
