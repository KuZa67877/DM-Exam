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



//--------------------
//ДАЛЬШЕ идут функции тестирования, отладки, для работы только выше, за исключением main
//-----------------

// void print_variant(List<List<int>> variant) {
//   print(variant[0]);
//   print(variant[1]);
//   print(variant[2]);
//   print(variant[3]);
// }

// void print_variant_more() {
//   for (int i = 1; i < 100; i++) {
//     List<List<int>> result = generate_full_variant();
//     print(result[0]);
//     print(result[1]);
//     print(result[2]);
//     print(result[3]);
//     print('');
//   }
// }

// void extra() {
//   for (int i = 1; i <= 100; i++) {
//     int num1 = Random().nextInt(160) + 40;
//     int num2 = Random().nextInt(160) + 10;
//     List<List<int>> result = evklid_lines_minus(num1, num2);
//     if (result[0].length < 10) {
//       print(result[0]);
//       print(result[1]);
//       print('');
//     } else {
//       //   extra();
//     }
//   }
// }

// void stats() {
//   List<int> count = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
//   List<double> stata = List.filled(15, 0);

//   for (int i = 1; i <= 1000000; i++) {
//     List<List<int>> result = generate_full_variant();
//     // print(result[0].length);
//     stata[result[0].length - 1] += 1;
//   }
//   print(stata);
//   print(count);
// }

// //---------------------

// void main() {
// //   final stopwatch = Stopwatch()..start();  //засекаем время
// //   extra();
//   // print_variant_more();
// //   print_variant(variant());
// //   stats();
//   // print_variant(variant());
//   // print_variant(evklid_lines_minus(83, 40));
//   //print('doSomething() executed in ${stopwatch.elapsed}');  //  выводим время
// }
