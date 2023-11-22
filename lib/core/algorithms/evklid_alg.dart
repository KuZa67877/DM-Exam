List<List<int>> evklidLinesMinus(int numX, int numY) {
  // Создаем списки для хранения значений
  List<int> line1 = <int>[numX, numY];
  List<int> line2 = <int>[0, 0];
  List<int> line3 = <int>[1, 0];
  List<int> line4 = <int>[0, 1];

  // Пока оба числа не равны нулю
  while (numX != 0 && numY != 0) {
    int tempUp = numX % numY;
    int tempDown = numX ~/ numY;
    line1.add(tempUp);
    line2.add(tempDown);
    numX = numY;
    numY = tempUp;
    int i = line1.length - 1;
    line3.add(line3[i - 2] - line2[i] * line3[i - 1]);
    line4.add(line4[i - 2] - line2[i] * line4[i - 1]);
  }
  return [line1, line2, line3, line4];
}

List<List<int>> evklidLinesPlus(int numX, int numY) {
  // Создаем списки для хранения значений
  List<int> line1 = <int>[numX, numY];
  List<int> line2 = <int>[0, 0];
  List<int> line4 = <int>[1, 0];
  List<int> line3 = <int>[0, 1];

  // Пока оба числа не равны нулю
  while (numX != 0 && numY != 0) {
    int tempUp = numX % numY;
    int tempDown = numX ~/ numY;
    line1.add(tempUp);
    line2.add(tempDown);
    numX = numY;
    numY = tempUp;
    int i = line1.length - 1;
    line3.add(line3[i - 2] + line2[i] * line3[i - 1]);
    line4.add(line4[i - 2] + line2[i] * line4[i - 1]);
  }
  return [line1, line2, line3, line4];
}
