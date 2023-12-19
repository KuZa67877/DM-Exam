String listConvertToPolyString(List<num> coefficients, int root) {
  coefficients = coefficients.reversed.toList();
  String rootstring = '';
  if (root < 0) {
    root = root.abs();
    rootstring = "(x + $root)";
  } else if (root > 0) {
    rootstring = "(x - $root)";
  } else if (root == 0) {
    rootstring = "x";
  }
  List<String> up_unicode = [
    '⁰',
    '¹',
    '²',
    '³',
    '⁴',
    '⁵',
    '⁶',
    '⁷',
    '⁸',
    '⁹'
  ]; // Создаем список надстрочных цифр
  // Проверяем, что лист не пустой
  if (coefficients.isEmpty) {
    return 'Пустой лист';
  }
  // Создаем пустую строку для результата
  String result = '';
  // Проходим по листу коэффициентов в обратном порядке
  for (int i = coefficients.length - 1; i >= 0; i--) {
    // Получаем текущий коэффициент и степень
    num coefficient = coefficients[i];
    int degree = i;
    // Пропускаем нулевые коэффициенты
    if (coefficient == 0) {
      continue;
    }
    // Добавляем знак плюс или минус в зависимости от знака коэффициента
    if (coefficient > 0 && result.isNotEmpty) {
      result += ' + ';
    } else if (coefficient < 0) {
      result += ' - ';
    }
    // Добавляем абсолютное значение коэффициента, если оно не равно единице или если степень равна нулю
    if (coefficient.abs() != 1 || degree == 0) {
      result += coefficient.abs().toString();
    }
    // Добавляем переменную x и степень, если степень больше нуля
    if (degree > 0) {
      result += rootstring;
      if (degree > 1) {
        result += up_unicode[degree];
      }
    }
  }
  // Возвращаем результат или сообщение, что многочлен нулевой
  return result.isNotEmpty ? result : 'Нулевой многочлен';
}
