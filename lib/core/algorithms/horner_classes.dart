import 'dart:math';
import 'poly_list_string_alg.dart';
import 'horner_alg.dart';
import 'task_interface.dart';

class HornerRoot extends Task {
  late int root;
  List<int> coefficients = List.empty(growable: true);
  List<int> process = List.empty(growable: true);
  String poly_string = '';
  late int answer;

  HornerRoot() {
    data = generateVariant();
    coefficients = data[0];
    process = data[1];
    lines = [
      coefficients,
      process,
      [process.last]
    ];
    poly_string = listConvertToPolyString(coefficients, 0);
    answer = process.last;
    linesCount = 3;
  }

  @override
  List<List<int>> generateVariant() {
    List<int> conditions;
    List<int> result = List.empty(growable: true);
    // int rand_len = Random().nextInt(3) + 6;
    int rand_len = Random().nextInt(2) + 5;
    var list_cond = [-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8];
    var list_root = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5];
    do {
      root = list_root[Random().nextInt(list_root.length)];
      conditions = List<int>.generate(
          rand_len, (i) => list_cond[Random().nextInt(list_cond.length)]);
      conditions[0] = list_root[Random().nextInt(list_root.length)];
      result = hornerScheme(conditions, root);
    } while (((result.last).abs() > 140) ||
        ((result.last).abs() < 15) ||
        (conditions.first == 0));
    return [conditions, result];
  }

  @override
  String writeQuestion() {
    String resultString =
        "Вычислите значение многочлена \n$poly_string\n в точке $root";
    return resultString;
  }

  @override
  List<String> generateInstruction() {
    List<String> instruction = [];
    instruction.add("Дан многочлен");
    instruction.add("# $poly_string");
    instruction.add(
        "Чтобы найти значение многочлена в точке $root, можно применить схему Горнера для деления многочлена на");
    instruction.add("# ${_monomialStr(root)}");
    instruction.add("как показано в таблице");
    return instruction;
  }

  String _monomialStr(int root) {
    String monomial = "(x - $root)";
    if (root < 0) {
      monomial = "(x + ${-root})";
    }
    return monomial;
  }
}

class HornerPoly extends Task {
  int root = 0;
  List<int> answer_coeffs = List.empty(growable: true);
  List<int> condition_coeffs = List.empty(growable: true);
  String condition_string = '';
  String answer_string = '';

  HornerPoly() {
    data = generateVariant();
    lines = data;
    condition_coeffs = lines[0];
    answer_coeffs = _getCoeffs(lines);
    condition_string = listConvertToPolyString(condition_coeffs, 0);
    answer_string = listConvertToPolyString(answer_coeffs, root);
    linesCount = lines.length;
  }

  List<List<int>> generateVariant() {
    List<int> conditions = List.empty(growable: true);
    List<int> current_line = List.empty(growable: true);
    List<List<int>> answer = List.empty(growable: true);
    int rand_len = Random().nextInt(2) + 6;
    var list_cond = [-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8];
    var list_root = [-6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6];
    do {
      conditions = List.empty(growable: true);
      answer = List.empty(growable: true);
      root = list_root[Random().nextInt(list_root.length)];
      conditions = List<int>.generate(
          rand_len, (i) => list_cond[Random().nextInt(list_cond.length)]);
      conditions[0] = list_root[Random().nextInt(list_root.length)];
      current_line = conditions;
      answer.add(current_line);
      for (int i = 0; i < conditions.length; i++) {
        current_line = hornerScheme(current_line, root);
        answer.add(current_line);
        current_line.removeLast();
      }
      answer.removeLast();
      answer[0].removeLast();
    } while (_checkfunc(answer));

    return answer;
  }

  @override
  String writeQuestion() {
    String resultString =
        "Разделите многочлен \n$condition_string\n на одночлен ${_monomialStr(root)} с помощью схемы Горнера";
    return resultString;
  }

  @override
  List<String> generateInstruction() {
    List<String> instruction = [];
    instruction.add("Дан многочлен");
    instruction.add("# $condition_string");
    instruction.add("и моном");
    instruction.add("# ${_monomialStr(root)}");
    instruction.add(
        "Чтобы поделить многочлен на моном, можно использовать схему Горнера, как показано в таблице");
    return instruction;
  }

  String _monomialStr(int root) {
    String monomial = "(x - $root)";
    if (root < 0) {
      monomial = "(x + ${-root})";
    }
    return monomial;
  }

  List<int> _getCoeffs(List<List<int>> lines) {
    List<int> result = List.empty(growable: true);
    for (int i = lines.length - 1; i > 0; i--) {
      result.add(lines[i].last);
    }
    return result;
  }

  bool _checkfunc(List<List<int>> data) {
    List<int> data_line = List.empty(growable: true);
    for (int i = 0; i < data.length; i++) {
      data_line.addAll(data[i]);
    }
    int maxi = data_line.reduce(max);
    int mini = data_line.reduce(min);
    if ((maxi.abs() > 140) || (mini.abs() > 140)) {
      return true;
    } else {
      return false;
    }
  }
}
