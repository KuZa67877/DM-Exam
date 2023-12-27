abstract class Task {
  late List<List<int>> lines;
  late final List<List<int>> data;
  int linesCount = 4; // По умолчанию устанавливаем 4 строки

  Task();

  List<List<int>> generateVariant();
  String writeQuestion();
  List<String> generateInstruction();
}
