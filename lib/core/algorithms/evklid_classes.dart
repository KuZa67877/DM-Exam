import 'dart:math';
import 'evklid_alg.dart';

abstract class Task {
  late final List<List<int>> data;
  int linesCount = 4; // По умолчанию устанавливаем 4 строки

  Task();

  List<List<int>> generateVariant();
  String writeQuestion();
}

class AxBy1 extends Task {
  //ax+by=1
  late int xCondition;
  late int yCondition;
  late int xAnswer;
  late int yAnswer;

  @override
  List<List<int>> generateVariant() {
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 6 || num1.gcd(num2) != 1);

    return result;
  }

  @override
  String writeQuestion() {
    String resultString =
        "Найти (x,y), удволетворяющие условию:\n$xCondition x + $yCondition y = 1";
    return resultString;
  }

  AxBy1() {
    data = generateVariant();
    xCondition = data[0][0];
    yCondition = data[0][1];
    xAnswer = data[2][data[2].length - 2];
    yAnswer = data[3][data[3].length - 2];
  }
}

class NOD extends Task {
  //НОД
  late int xCondition;
  late int yCondition;
  late int answer;
  late List<int> firstline;
  late List<int> secondline;
  late List<int> thirdline;
  late List<int> fourthLine;

  NOD() {
    data = generateVariant();
    xCondition = data[0][0];
    yCondition = data[0][1];
    answer = data[0][data[0].length - 2];
    firstline = data[0];
    secondline = data[1];
    thirdline = [];
    fourthLine = [];
    linesCount = 2; // Устанавливаем 2 строки
  }

  @override
  List<List<int>> generateVariant() {
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
    } while (result[0].length < 4 || result[0].length > 7);

    return result.sublist(0, result.length ~/ 2);
  }

  @override
  String writeQuestion() {
    String resultString = "Найдите НОД($xCondition;$yCondition)";
    return resultString;
  }
}

class ContinuedFraction extends Task {
  //Цепная дробь
  late int xCondition;
  late int yCondition;
  late String answer;
  late List<int> firstline;
  late List<int> secondline;
  late List<int> thirdline;
  late List<int> fourthLine;

  ContinuedFraction() {
    data = generateVariant();
    xCondition = data[0][0];
    yCondition = data[0][1];
    firstline = data[0];
    secondline = data[1];
    thirdline = [];
    fourthLine = [];
    linesCount = 2;
    answer = '';
    if (secondline[2] == 0) {
      answer = '[${secondline[3]},';
      for (int i = 4; i < secondline.length - 1; i++) {
        answer = '$answer${secondline[i]},';
      }
      answer = '$answer${secondline[secondline.length - 1]}]';
    } else {
      answer = '[${secondline[2]};';
      for (int i = 3; i < secondline.length - 1; i++) {
        answer = '$answer${secondline[i]},';
      }
      answer = '$answer${secondline[secondline.length - 1]}]';
    }
  }

  @override
  List<List<int>> generateVariant() {
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesMinus(num1, num2);
    } while (result[0].length < 4 || result[0].length > 7);

    return result;
  }

  @override
  String writeQuestion() {
    String resultString =
        "Найдите представление рационального числа $xCondition/$yCondition непрерывной дробью";
    return resultString;
  }
}

class InverseNumber extends Task {
  //Обратный элемент в кольце вычетов по модулю
  late int xCondition;
  late int yCondition;
  late int answer;
  late List<int> firstline;
  late List<int> secondline;
  late List<int> thirdline;
  late List<int> fourthLine;

  InverseNumber() {
    this.data = generateVariant();
    xCondition = data[0][0];
    yCondition = data[0][1];
    if (data[3][data[3].length - 2] >= 0) {
      answer = data[3][data[3].length - 2];
    } else {
      answer = data[3][data[3].length - 2] + xCondition;
    }
    firstline = data[0];
    secondline = data[1];
    thirdline = List.filled(data[2].length, 0);
    fourthLine = data[3];
    answer = 0;
  }

  @override
  List<List<int>> generateVariant() {
    int num1;
    int num2;
    List<List<int>> result;

    do {
      num1 = Random().nextInt(250) + 50;
      num2 = Random().nextInt(20) + 5;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 7 || num1.gcd(num2) != 1);

    return result;
  }

  @override
  String writeQuestion() {
    String resultString =
        "Найти обратный элемент к $yCondition в поле вычетов по модулю $xCondition";
    return resultString;
  }
}

class SuitableFractions extends Task {
  //Подходящие дроби
  late int xCondition;
  late int yCondition;
  late List answer;
  late List<int> firstline;
  late List<int> secondline;
  late List<int> thirdline;
  late List<int> fourthLine;

  SuitableFractions() {
    data = generateVariant();
    xCondition = data[0][0];
    yCondition = data[0][1];
    firstline = data[0];
    secondline = data[1];
    thirdline = data[2];
    fourthLine = data[3];
    answer = []; // инициализация answer
    for (int i = 2; i < data[2].length; i++) {
      int numerator = data[2][i];
      int denominator = data[3][i];
      if (numerator > 0) {
        answer.add('$numerator/$denominator');
      }
    }
  }

  @override
  List<List<int>> generateVariant() {
    //для подходящих дробей
    int num1;
    int num2;
    List<List<int>> result;
    do {
      num1 = Random().nextInt(160) + 40;
      num2 = Random().nextInt(160) + 10;
      result = evklidLinesPlus(num1, num2);
    } while (result[0].length < 4 || result[0].length > 7);

    return result;
  }

  @override
  String writeQuestion() {
    String resultString = "Найти подходящие дроби к $xCondition/$yCondition";
    return resultString;
  }
}

class Diafant extends Task {
  //Решение "полного" диофантово уравнения
  late int a1;
  late int b1;
  late int c1;
  late int A;
  late int B;
  late int C;
  late int nod;
  late int x1DivC1;
  late int y1DivC1;
  late int x1Answer;
  late int y1Answer;
  late int tX;
  late int tY;
  late String xAnswer;
  late String yAnswer;
  late List<int> firstline;
  late List<int> secondline;
  late List<int> thirdline;
  late List<int> fourthLine;
  Diafant() {
    data = generateVariant();
    a1 = data[0][0];
    b1 = data[0][1];
    x1DivC1 = data[2][data[2].length - 2];
    y1DivC1 = data[3][data[3].length - 2];
    do {
      c1 = Random().nextInt(20) + 3;
    } while ((a1 * x1DivC1 + b1 * y1DivC1) % 2 != c1 % 2);
    nod = Random().nextInt(30) + 2;
    A = a1 * nod;
    B = b1 * nod;
    C = c1 * nod;
    x1Answer = x1DivC1 * c1;
    y1Answer = y1DivC1 * c1;
    tX = (-1) * data[2][data[2].length - 1];
    tY = (-1) * data[3][data[3].length - 1];

    firstline = data[0];
    secondline = data[1];
    thirdline = data[2];
    fourthLine = data[3];
    xAnswer = '$x1Answer + $tX t';
    yAnswer = '$y1Answer + $tY t';
  }

  @override
  List<List<int>> generateVariant() {
    int num1;
    int num2;
    List<List<int>> result;

    do {
      num1 = Random().nextInt(48) + 3;
      num2 = Random().nextInt(48) + 3;
      result = evklidLinesMinus(num1, num2);
    } while (
        result[0].length < 4 || result[0].length > 7 || num1.gcd(num2) != 1);

    return result;
  }

  @override
  String writeQuestion() {
    String resultString = "Решите диофантово уравнение:\n $A x + $B y = $C";
    return resultString;
  }
}
