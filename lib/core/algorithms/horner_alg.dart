List<int> hornerScheme(List<int> coefficients, int x0) {
  // Проверяем, что список коэффициентов не пустой
  if (coefficients.isEmpty) {
    return List.empty();
  }
  List<int> answer = List.empty(growable: true);
  // Инициализируем переменную result значением последнего элемента списка
  int result = coefficients.first;
  answer.add(result);

  // Проходим по коэффициентам в обратном порядке, начиная с предпоследнего
  for (int i = 1; i < coefficients.length; i++) {
    // Обновляем значение result по формуле схемы Горнера
    result = result * x0 + coefficients[i];
    answer.add(result);
  }

  // Возвращаем значение answer
  return answer;
}
