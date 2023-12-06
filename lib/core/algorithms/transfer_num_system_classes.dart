import 'task_interface.dart';
import 'dart:math';

class TransferNumSystem extends Task {
  late int num;
  late int sourceSystem;
  late int toTransferSystem;

  TransferNumSystem() {
    data = generateVariant();
  }

  @override
  List<List<int>> generateVariant() {
    sourceSystem = 2 + Random().nextInt(9);
    num = int.parse(Random().nextInt(10000).toRadixString(sourceSystem));
    toTransferSystem = 2 + Random().nextInt(9);
    return transferNumSystem(num, sourceSystem, toTransferSystem);
  }

  @override
  String writeQuestion() {
    String question =
        "Переведите число ${data[0]}, представленное в ${data[1]}-ной системе счисления в ${data[2]}-ную";
    return question;
  }

  List<List<int>> transferNumSystem(
      int num, int numSystem, int toTransferSystem) {
    List<int> numList =
        num.toString().split('').map((x) => int.parse(x)).toList();
    List<int> values = [];
    values.add(numList[0]);
    for (int i = 1; i < numList.length; i++)
      values.add(numSystem * values[i - 1] + numList[i]);
    List<int> valuesInSystem = values
        .map((x) => int.parse(x.toRadixString(toTransferSystem)))
        .toList();
    return [numList, valuesInSystem];
  }
}
