abstract class Task {
  late final List<List<int>> data;

  Task();

  List<List<int>> generateVariant();
  String writeQuestion();
}
