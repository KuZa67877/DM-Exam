import 'evklid_classes.dart';
import 'dart:io';

void main() {
  final stopwatch = Stopwatch()..start(); //засекаем время
  AxBy1 variantAxBy1 = AxBy1();
  variantAxBy1.display();
  print('');
  NOD variantNOD = NOD();
  variantNOD.display();
  print('');
  Cepnaya variantCepnaya = Cepnaya();
  variantCepnaya.display();
  print('');
  Opposite variantOpposite = Opposite();
  variantOpposite.display();
  print('');
  Suitable variantSuitable = Suitable();
  variantSuitable.display();
  print('');
  Diafant variantDiafant = Diafant();
  variantDiafant.display();
  print('');
  print('');
  print('Время: ${stopwatch.elapsed}'); //  выводим время
  print("enter to exit:"); //не закрывают консоль в exe, но создаёт ошибку в
  stdin.readLineSync();

  for (int i = 0; i < 10; i++) {
    // AxBy1 variant_AxBy1 = AxBy1();
    // variant_AxBy1.display();
  }
}
