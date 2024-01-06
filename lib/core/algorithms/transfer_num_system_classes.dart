import 'task_interface.dart';
import 'dart:math';

class TransferNumSystem extends Task {
  late int num;
  late int sourceSystem;
  late int toTransferSystem;

  TransferNumSystem() {
    data = generateVariant();
    lines = data;
    linesCount = 2;
  }

  @override
  List<List<int>> generateVariant() {
    sourceSystem = 2 + Random().nextInt(9);
    toTransferSystem = 2 + Random().nextInt(9);
    while (toTransferSystem == sourceSystem) {
      toTransferSystem = 2 + Random().nextInt(9);
    }
    int to = [pow(sourceSystem, 7).toInt(), pow(toTransferSystem, 5).toInt()]
        .reduce(min);
    int from = [pow(sourceSystem, 3).toInt(), pow(toTransferSystem, 4).toInt()]
        .reduce(min);
    num = int.parse(
        (from + Random().nextInt(to - from)).toRadixString(sourceSystem));
    return transferNumSystem(num, sourceSystem, toTransferSystem);
  }

  @override
  String writeQuestion() {
    String question =
        "Переведите число $num, представленное в $sourceSystem-ной системе счисления в $toTransferSystem-ную";
    return question;
  }

  @override
  List<String> generateInstruction() {
    List<String> instruction = [];
    instruction.add(
        "Дано число $num в $sourceSystem-ной СС, которое нужно перевести в $toTransferSystem-ную СС");
    instruction.add("Для этого запишем $num в верхний ряд таблицы");
    instruction.add(
        "Алгоритм переведения числа $num в $toTransferSystem-ную CC схож с алгоритмом Горнера, а именно - в качестве корня монома берется основание данного числа, цифры числа представляются как коэффициенты мн-на");
    instruction.add("Но есть одно важное отличие");
    instruction.add(
        "ВАЖНО!!! Для переведения в $toTransferSystem-ную СС все арифметические операции должны проводиться в $toTransferSystem-ной СС.");
    instruction.add(
        "Возможно, для этого понадобится таблица умножения в $toTransferSystem-ной СС");
    return instruction;
  }

  List<List<int>> transferNumSystem(
      int num, int numSystem, int toTransferSystem) {
    List<int> numList =
        num.toString().split('').map((x) => int.parse(x)).toList();
    List<int> values = [];
    values.add(numList[0]);
    for (int i = 1; i < numList.length; i++) {
      values.add(numSystem * values[i - 1] + numList[i]);
    }
    List<int> valuesInSystem = values
        .map((x) => int.parse(x.toRadixString(toTransferSystem)))
        .toList();
    return [numList, valuesInSystem];
  }
}
