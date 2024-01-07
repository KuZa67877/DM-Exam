import 'task_interface.dart';
import 'dart:math';

class QuickPow extends Task {
  late int num;
  late int power;
  late String bin_power;

  QuickPow() {
    data = generateVariant();
    bin_power = power.toRadixString(2);
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

  @override
  List<String> generateInstruction() {
    List<String> instruction = [];
    instruction.add(
        "Даны число $num и степень $power, в которую нужно возвести это число");
    instruction.add(
        "Чтобы возвести число в степень, вы должны использовать алгоритм быстрого возведения в степень");
    instruction.add(
        "Сначала степень, в которую нужно возвести число, приведем к двоичному предствалению, получим");
    instruction.add("# $power = $bin_power");
    instruction.add(
        "Далее цифры двоичного представления запишем в первый ряд таблицы");
    instruction.add(
        "Для возведения числа в степень в первую ячейку второго ряда перенесем основание $num");
    instruction.add(
        "Далее для определения значения в каждой следующей ячейке юудем использовать значение предыдущей ячейки следующим образом:");
    instruction.add(
        "1. Если в первом ряду над очередной незаполненной ячейкой находится 0, то возводим значение предыдущей ячейки в квадрат");
    instruction.add(
        "2. Если в первом ряду над очередной незаполненной ячейкой находится 1, то возводим значение предыдущей ячейки в квадрат и умножаем на основание $num");
    instruction.add(
        "Таким образом в последней ячейке второго ряда получим число $num в степени $power");
    return instruction;
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
