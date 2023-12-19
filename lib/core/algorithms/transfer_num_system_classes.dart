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
    num = int.parse(Random()
        .nextInt(pow(sourceSystem, 7).toInt())
        .toRadixString(sourceSystem));
    return transferNumSystem(num, sourceSystem, toTransferSystem);
  }

  @override
  String writeQuestion() {
    String question =
        "Переведите число $num, представленное в $sourceSystem-ной системе счисления в $toTransferSystem-ную";
    return question;
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
