import 'dart:math';
import 'evklid_alg.dart';

class AxBy1 {
  List<List<int>> data = [];
  int x_condition = 0;
  int y_condition = 0;
  int x_answer = 0;
  int y_answer = 0;
  List line1 = List.empty();
  List line2 = List.empty();
  List line3 = List.empty();
  List line4 = List.empty();

  AxBy1() {
    data = _generate_AxBy1_variant();
    x_condition = data[0][0];
    y_condition = data[0][1];
    x_answer = data[2][data[2].length - 2];
    y_answer = data[3][data[3].length - 2];
    line1 = data[0];
    line2 = data[1];
    line3 = data[2];
    line4 = data[3];
  }

  List<List<int>> _generate_AxBy1_variant() {
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 10 || num1.gcd(num2) != 1);

    return result;
  }

  void display() {
    print("$x_condition x + $y_condition y = 1");
    // print("x_cond: $x_condition y_cond: $y_condition");
    print(line1);
    print(line2);
    print(line3);
    print(line4);
    print("Ответ: ($x_answer;$y_answer)");
  }
}

class NOD {
  int x_condition = 0;
  int y_condition = 0;
  int answer = 0;
  List line1 = List.empty();
  List line2 = List.empty();
  NOD() {
    List<List<int>> data = _generate_NOD_variant();
    x_condition = data[0][0];
    y_condition = data[0][1];
    answer = data[0][data[0].length - 2];
    line1 = data[0];
    line2 = data[1];
  }

  List<List<int>> _generate_NOD_variant() {
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      if (num1 < num2) {
        int temp = num1;
        num1 = num2;
        num2 = temp;
      }
      result = evklidLinesMinus(num1, num2);
    } while (result[0].length < 4 || result[0].length > 10);

    return result;
  }

  void display() {
    print("НОД($x_condition;$y_condition)");
    print(line1);
    print(line2);
    print("Ответ: $answer");
  }
}

class Cepnaya {
  int x_condition = 0;
  int y_condition = 0;
  String answer = '';
  List line1 = List.empty();
  List line2 = List.empty();
  Cepnaya() {
    List<List<int>> data = _generate_Cepnaya_variant();
    x_condition = data[0][0];
    y_condition = data[0][1];
    line1 = data[0];
    line2 = data[1];
    if (line2[2] == 0) {
      answer = '[' + line2[3].toString() + ',';
      for (int i = 4; i < line2.length - 1; i++) {
        answer = '$answer' + line2[i].toString() + ',';
      }
      answer = '$answer' + line2[line2.length - 1].toString() + ']';
    } else {
      answer = '[' + line2[2].toString() + ';';
      for (int i = 3; i < line2.length - 1; i++) {
        answer = '$answer' + line2[i].toString() + ',';
      }
      answer = '$answer' + line2[line2.length - 1].toString() + ']';
    }
  }

  List<List<int>> _generate_Cepnaya_variant() {
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesMinus(num1, num2);
    } while (result[0].length < 4 || result[0].length > 10);

    return result;
  }

  void display() {
    print("Дана дробь $x_condition/$y_condition");
    print(line1);
    print(line2);
    print("Ответ: $answer");
  }
}

class Opposite {
  int x_condition = 0;
  int y_condition = 0;
  int answer = 0;
  List line1 = List.empty();
  List line2 = List.empty();
  List line3 = List.empty();
  List line4 = List.empty();
  Opposite() {
    List<List<int>> data = _generate_opposite_variant();
    x_condition = data[0][0];
    y_condition = data[0][1];
    if (data[3][data[3].length - 2] >= 0)
      answer = data[3][data[3].length - 2];
    else
      answer = data[3][data[3].length - 2] + x_condition;
    line1 = data[0];
    line2 = data[1];
    line3 = List.filled(data[2].length, 0);
    line4 = data[3];
  }

  List<List<int>> _generate_opposite_variant() {
    int num1;
    int num2;
    List<List<int>> result;

    do {
      num1 = Random().nextInt(250) + 50;
      num2 = Random().nextInt(20) + 5;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 10 || num1.gcd(num2) != 1);

    return result;
  }

  void display() {
    print(
        "Найти обратный элемент к $y_condition в поле вычетов по модулю $x_condition");
    print(line1);
    print(line2);
    print(line3);
    print(line4);
    print("Ответ: $answer");
  }
}

class Suitable {
  int x_condition = 0;
  int y_condition = 0;
  List answer = [];
  List line1 = List.empty();
  List line2 = List.empty();
  List line3 = List.empty();
  List line4 = List.empty();

  Suitable() {
    List<List<int>> data = _generate_suitable_variant();
    x_condition = data[0][0];
    y_condition = data[0][1];
    line1 = data[0];
    line2 = data[1];
    line3 = data[2];
    line4 = data[3];
    for (int i = 2; i < data[2].length; i++) {
      int numerator = data[2][i];
      int denominator = data[3][i];
      if (numerator > 0) {
        answer.add('$numerator/$denominator');
      }
    }
  }

  List<List<int>> _generate_suitable_variant() {
    //для подходящих дробей
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesPlus(num1, num2);
    } while (result[0].length < 4 || result[0].length > 10);

    return result;
  }

  void display() {
    print("Найти подходящие дроби к $x_condition/$y_condition");
    print(line1);
    print(line2);
    print(line3);
    print(line4);
    print("Ответ: $answer");
  }
}

class Diafant {
  int a1 = 0;
  int b1 = 0;
  int c1 = 0;
  int A = 0;
  int B = 0;
  int C = 0;
  int nod = 0;
  int _x1_answer_denom_c1 = 0;
  int _y1_answer_denom_c1 = 0;
  int x1_answer = 0;
  int y1_answer = 0;
  int _t_x = 0;
  int _t_y = 0;
  String X_answer = '';
  String Y_answer = '';
  List line1 = List.empty();
  List line2 = List.empty();
  List line3 = List.empty();
  List line4 = List.empty();
  Diafant() {
    List<List<int>> data = _generateDiafantVariant();
    a1 = data[0][0];
    b1 = data[0][1];
    _x1_answer_denom_c1 = data[2][data[2].length - 2];
    _y1_answer_denom_c1 = data[3][data[3].length - 2];
    do {
      c1 = Random().nextInt(20) + 3;
    } while (
        (a1 * _x1_answer_denom_c1 + b1 * _y1_answer_denom_c1) % 2 != c1 % 2);
    nod = Random().nextInt(30) + 2;
    A = a1 * nod;
    B = b1 * nod;
    C = c1 * nod;
    x1_answer = _x1_answer_denom_c1 * c1;
    y1_answer = _y1_answer_denom_c1 * c1;
    _t_x = (-1) * data[2][data[2].length - 1];
    _t_y = (-1) * data[3][data[3].length - 1];

    line1 = data[0];
    line2 = data[1];
    line3 = data[2];
    line4 = data[3];
    X_answer = '$x1_answer + $_t_x t';
    Y_answer = '$y1_answer + $_t_y t';
  }

  List<List<int>> _generateDiafantVariant() {
    int num1;
    int num2;
    List<List<int>> result;

    do {
      num1 = Random().nextInt(48) + 3;
      num2 = Random().nextInt(48) + 3;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 10 || num1.gcd(num2) != 1);

    return result;
  }

  void display() {
    print("Решите уравнение $A x + $B y = $C");
    print("НОД(a,b,c): $nod");
    print("a1 = $a1;  b1 = $b1;  c1 = $c1");
    print(line1);
    print(line2);
    print(line3);
    print(line4);
    print("Ответ:");
    print('x = $X_answer');
    print('y = $Y_answer');
  }
}
