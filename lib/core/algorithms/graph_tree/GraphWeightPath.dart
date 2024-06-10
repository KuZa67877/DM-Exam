import 'GraphWeight.dart';
import 'dart:math';
import 'dart:collection';

class GraphWeightPath extends GraphWeight {
  //список с количеством выходов из вершин
  Map<int, int> vertexes_to = {};
  //список с количеством входом в вершины
  Map<int, int> vertexes_in = {};
  @override
  void generate_graph() {
    var random = Random();
    create_empty_graph(5);

    for (var i = 1; i <= w_graph.length; i++) {
      vertexes_to[i] = 0;
      vertexes_in[i] = 0;
    }

    var fl = true;

    MapEntry<int, int> min_to =
        find_min(vertexes_to); //вершина из которой пойдём
    MapEntry<int, int> min_in =
        find_min(vertexes_in); //вершина в которую пойдём

    while ((min_to.value < 3 || min_in.value < 3) && fl) {
      bool was_reverse = (w_graph[min_in.key]?.containsKey(min_to.key) ??
          false); //есть уже обратный путь
      bool was_yet = (w_graph[min_to.key]?.containsKey(min_in.key) ??
          false); //уже существует путь, который мы хотим построить

      if (min_to.key != min_in.key &&
          !(was_yet ||
              was_reverse)) //если вершины не совпадают и два условия выше выполняются
      {
        w_graph[min_to.key]?[min_in.key] = random.nextInt(12) + 3;
        vertexes_to[min_to.key] = (vertexes_to[min_to.key] ?? 0) + 1;
        vertexes_in[min_in.key] = (vertexes_in[min_in.key] ?? 0) + 1;
      } else {
        //флаг мб можно будет убрать, он необходим был для старой версии алгоритма
        fl = false;

        var sortedEntries_in = vertexes_in.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));
        LinkedHashMap<int, int> sorted_in =
            LinkedHashMap.fromEntries(sortedEntries_in);
        //отсортировали мапу и идём по ней, пока не будет вершины, в которую можно проложить путь
        for (var ver_in in sorted_in.entries) {
          //те же условия на наличия путей
          was_reverse = (w_graph[ver_in.key]?.containsKey(min_to.key) ?? false);
          was_yet = (w_graph[min_to.key]?.containsKey(ver_in.key) ?? false);
          //если сопали или есть пути, продолжаем перебор
          if (min_to.key == ver_in.key || (was_yet || was_reverse))
            continue;
          else {
            w_graph[min_to.key]?[ver_in.key] = random.nextInt(12) + 3;
            vertexes_to[min_to.key] = (vertexes_to[min_to.key] ?? 0) + 1;
            vertexes_in[ver_in.key] = (vertexes_in[ver_in.key] ?? 0) + 1;
            fl =
                true; //мы не перебрали все варианты -> нашли подходящий -> можно продолжать цикл
            break;
          }
        }
      }
      min_to = find_min(vertexes_to);
      min_in = find_min(vertexes_in);
    }
  }

  //рандомно выбираем вершину, так, чтобы количество входов или выходов в неё было минимальным (выбираем вершину среди минимальных)
  MapEntry<int, int> find_min(Map<int, int> count_of_paths) {
    if (count_of_paths.isEmpty) return (MapEntry(1, 0));
    List<int> fit_ver = [];
    int min_count = 1024;
    for (var pair in count_of_paths.entries) {
      if (pair.value < min_count) {
        fit_ver.clear();
        fit_ver.add(pair.key);
        min_count = pair.value;
      } else if (pair.value == min_count) {
        fit_ver.add(pair.key);
      }
    }
    var random = Random();
    var len = fit_ver.length - 1;
    var ind = 0;
    if (len > 0) ind = random.nextInt(len);
    var element = fit_ver[ind];
    return MapEntry(element, count_of_paths[element] ?? 0);
  }

  List<List<int>> find_path() {
    int len = w_graph.length;
    int infinity =
        1000000000; // Большое конечное значение, используемое вместо бесконечности
    List<List<int>> paths =
        List.generate(len, (i) => List.filled(len, infinity));

    for (int i = 1; i <= len; i++) {
      for (int j = 1; j <= len; j++) {
        if (i == j) {
          paths[i - 1][j - 1] = 0;
        } else if (w_graph[i]?.containsKey(j) == true) {
          paths[i - 1][j - 1] = w_graph[i]![j]!;
        }
      }
    }

    for (int k = 0; k < len; k++) {
      for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
          if (paths[i][k] < infinity && paths[k][j] < infinity) {
            if (paths[i][j] > paths[i][k] + paths[k][j]) {
              paths[i][j] = paths[i][k] + paths[k][j];
            }
          }
        }
      }
    }
    return paths;
  }

  List<String> findPathSteps() {
    int len = w_graph.length; // количество вершин
    List<List<int>> paths = List.generate(len, (i) => List.filled(len, 10 ^ 6));
    List<String> steps = [];

    // Заполняем матрицу путей
    for (int i = 1; i <= len; i++) {
      for (int j = 1; j <= len; j++) {
        if (i == j) {
          paths[i - 1][j - 1] = 0; // путь самой в себя
        } else if (w_graph[i]?.containsKey(j) == true) {
          paths[i - 1][j - 1] = w_graph[i]![j]!;
        }
      }
    }

    steps.add("Начальная матрица путей:\n${pathsToString(paths)}");

    // Алгоритм Флойда-Уоршелла для нахождения кратчайших путей
    for (int k = 0; k < len; k++) {
      for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
          if (paths[i][j] > paths[i][k] + paths[k][j]) {
            paths[i][j] = paths[i][k] + paths[k][j];
            steps.add(
                "Обновление пути [$i][$j] через вершину $k: \n${pathsToString(paths)}");
          }
        }
      }
    }

    steps.add("Итоговая матрица кратчайших путей:\n${pathsToString(paths)}");

    return steps;
  }

  String pathsToString(List<List<int>> paths) {
    StringBuffer buffer = StringBuffer();
    for (var row in paths) {
      buffer.writeln(row.join(' '));
    }
    return buffer.toString();
  }
}
