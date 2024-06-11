import 'GraphWeight.dart';
import 'dart:math';
import 'dart:collection';

class GraphWeightFlow extends GraphWeight {
  //я не придумал как релаизовать адекватней. Здесь списки вершин и куда из них можно простроить путь, окромя базового контура
  Map<int, Set<int>> neighbours = {
    2: {3, 6, 7},
    3: {2, 4, 5, 6, 7, 8, 10},
    4: {3, 5, 6},
    5: {6, 9, 10},
    6: {5, 8, 9, 10, 7},
    7: {8, 9},
    8: {9},
    9: {8, 10},
    10: {9}
  };
  //Мапа для подсчёта количества рёбер, приходящих в граф, чтобы граф не был перенасыщен
  Map<int, int> vertex_to = {
    2: 1,
    3: 0,
    4: 1,
    5: 1,
    6: 0,
    7: 1,
    8: 1,
    9: 0,
    10: 1
  };
  //Мапа загруженности вершины (количество входящих и выходящих рёбер)
  Map<int, int> vertex_summ = {
    2: 2,
    3: 1,
    4: 2,
    5: 2,
    6: 0,
    7: 2,
    8: 2,
    9: 1,
    10: 2
  };

  @override
  void generate_graph() {
    create_empty_graph(11);
    var start = 1;
    var finish = 11;
    var random = Random();

    //заполняем базовыми рёбрами, которые необходимы для адекватного веса

    for (var i = 2; i <= 4; i++) {
      // w_graph[start]![i] = random.nextInt(15)+4;
      w_graph[start]?[i] = w_graph[start]?[i] ?? random.nextInt(15) + 4;
    }
    for (var i = 10; i >= 8; i--) {
      // w_graph[i]![finish] = random.nextInt(12)+7;
      w_graph[i]?[finish] = w_graph[i]?[finish] ?? random.nextInt(12) + 7;
    }
    for (var i in {2, 4, 5, 7}) {
      // w_graph[i]![i+3] = random.nextInt(15)+4;
      w_graph[i]?[i + 3] = w_graph[i]?[i + 3] ?? random.nextInt(15) + 4;
    }
    //а теперь заполняем всё остальное, связывая вершины на рандом возможными рёбрами
    for (var paths in neighbours.entries) {
      for (var vertex in paths.value) {
        //проверяем, чтобы из вершины, куда строим ребро, не шло ребро в текущую вершину
        bool fl = w_graph[vertex]?.containsKey(paths.key) ?? false;
        // проверяем, чтобы вершины не были перегружены
        bool fl_len =
            (vertex_summ[vertex] ?? 0) < 3 && (vertex_summ[paths.key] ?? 0) < 3;

        if (!fl && fl_len && random.nextDouble() < 0.3) {
          w_graph[paths.key]![vertex] = random.nextInt(15) + 4;
          //заполняем данные о загруженности впершин
          vertex_to[vertex] = (vertex_to[vertex] ?? 0) + 1;
          vertex_summ[vertex] = (vertex_summ[vertex] ?? 0) + 1;
          vertex_summ[paths.key] = (vertex_summ[paths.key] ?? 0) + 1;
        }
      }
    }
    check_fill();
  }

  void check_fill() {
    var random = Random();
    for (var pair in vertex_to.entries) {
      if (pair.value == 0) //если в эту вершину нет путей
      {
        var sortedEntries = vertex_summ.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));

        // Создаем новую LinkedHashMap из отсортированных пар
        LinkedHashMap<int, int> sortedMap =
            LinkedHashMap.fromEntries(sortedEntries);
        for (var vertexes in sortedMap.entries) {
          //проверяем, нет ли уже обратного пути
          bool fl = w_graph[pair.key]?.containsKey(vertexes.key) ?? false;
          //проверка, можно ли вообще в эту вершину путь построить
          if ((neighbours[vertexes.key]?.contains(pair.key) ?? false) && !fl) {
            w_graph[vertexes.key]![pair.key] = random.nextInt(15) + 4;

            vertex_to[pair.key] = (vertex_to[pair.key] ?? 0) + 1;
            vertex_summ[vertexes.key] = (vertex_summ[vertexes.key] ?? 0) + 1;
            vertex_summ[pair.key] = (vertex_summ[pair.key] ?? 0) + 1;
            break;
          }
        }
      }
      if (pair.value ==
          vertex_summ[pair.key]) //если в эту вершину есть пути, но из неё нет
      {
        var sortedEntries = vertex_summ.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));

        // Создаем новую LinkedHashMap из отсортированных пар
        LinkedHashMap<int, int> sortedMap =
            LinkedHashMap.fromEntries(sortedEntries);
        print(sortedMap);
        for (var vertexes in sortedMap.entries) {
          //проверяем, нет ли уже обратного пути
          bool fl = w_graph[pair.key]?.containsKey(vertexes.key) ?? false;
          //проверка, можно ли вообще в эту вершину путь построить
          if ((neighbours[pair.key]?.contains(vertexes.key) ?? false) && fl) {
            w_graph[pair.key]![vertexes.key] = random.nextInt(15) + 4;

            vertex_to[vertexes.key] = (vertex_to[vertexes.key] ?? 0) + 1;
            vertex_summ[vertexes.key] = (vertex_summ[vertexes.key] ?? 0) + 1;
            vertex_summ[pair.key] = (vertex_summ[pair.key] ?? 0) + 1;
            break;
          }
        }
      }
    }
  }

  int dfs(int u, int t, int cMin, List<bool> visited,
      Map<int, Map<int, int>> copy) {
    if (u == t) {
      return cMin;
    }
    visited[u] = true;

    for (var v in copy[u]!.keys) {
      if (!visited[v] && copy[u]![v]! > 0) {
        int delta = dfs(v, t, min(cMin, copy[u]![v]!), visited, copy);
        if (delta > 0) {
          copy[u]![v] = copy[u]![v]! - delta;
          copy[v]?[u] = (copy[v]?[u] ?? 0) + delta;
          return delta;
        }
      }
    }
    return 0;
  }

  int ford_fulkerson() {
    int source = 1; // Источник (start)
    int sink = 11; // Сток (finish)
    int maxFlow = 0;

    List<bool> visited = List.filled(12, false);
    var max;

    Map<int, Map<int, int>> copy = {};
    w_graph.forEach((key, value) {
      copy[key] = Map<int, int>.from(value);
    });

    while (true) {
      max = 10 ^ 6;
      visited = List.filled(12, false);
      int flow = dfs(source, sink, max, visited, copy);
      if (flow == 0) {
        break;
      }
      maxFlow += flow;
    }
    print(copy);
    return maxFlow;
  }

  List<String> ford_fulkerson_steps() {
    int source = 1; // Источник (start)
    int sink = 11; // Сток (finish)
    int maxFlow = 0;
    List<String> steps = [];

    List<bool> visited = List.filled(12, false);
    var max;

    Map<int, Map<int, int>> copy = {};
    w_graph.forEach((key, value) {
      copy[key] = Map<int, int>.from(value);
    });

    while (true) {
      max = 10 ^ 6;
      visited = List.filled(12, false);
      List<int> path = [];
      int flow = dfs_with_path(source, sink, max, visited, copy, path);
      if (flow == 0) {
        break;
      }
      maxFlow += flow;
      steps.add(
          "Найден поток: $flow, путь: ${path.join(' -> ')}, текущий максимальный поток: $maxFlow");
    }
    steps.add("Итоговый максимальный поток: $maxFlow");
    return steps;
  }

  int dfs_with_path(int u, int t, int cMin, List<bool> visited,
      Map<int, Map<int, int>> copy, List<int> path) {
    path.add(u);
    if (u == t) {
      return cMin;
    }
    visited[u] = true;

    for (var v in copy[u]!.keys) {
      if (!visited[v] && copy[u]![v]! > 0) {
        int delta =
            dfs_with_path(v, t, min(cMin, copy[u]![v]!), visited, copy, path);
        if (delta > 0) {
          copy[u]![v] = copy[u]![v]! - delta;
          copy[v]?[u] = (copy[v]?[u] ?? 0) + delta;
          return delta;
        }
      }
    }
    path.removeLast();
    return 0;
  }

  bool bfs(
      Map<int, Map<int, int>> graph, int source, int sink, List<int> parent) {
    List<bool> visited = List.filled(graph.length + 1, false);
    Queue<int> queue = Queue<int>();
    queue.add(source);
    visited[source] = true;

    while (queue.isNotEmpty) {
      int u = queue.removeFirst();

      for (var v in graph[u]!.keys) {
        if (!visited[v] && graph[u]![v]! > 0) {
          queue.add(v);
          visited[v] = true;
          parent[v] = u;
          if (v == sink) {
            return true;
          }
        }
      }
    }
    return false;
  }

  int edmonds_karp() {
    int maxFlow = 0;
    int source = 1; // Источник (start)
    int sink = 11;

    // Создание копии графа
    Map<int, Map<int, int>> copy = {};
    w_graph.forEach((key, value) {
      copy[key] = Map<int, int>.from(value);
    });

    List<int> parent = List.filled(w_graph.length + 1, -1);

    while (bfs(copy, source, sink, parent)) {
      int pathFlow = 10 ^ 6;
      int v = sink;

      while (v != source) {
        int u = parent[v];
        pathFlow = min(pathFlow, copy[u]![v]!);
        v = parent[v];
      }

      v = sink;
      while (v != source) {
        int u = parent[v];
        copy[u]![v] = copy[u]![v]! - pathFlow;
        copy[v]?[u] = (copy[v]?[u] ?? 0) + pathFlow;
        v = parent[v];
      }

      maxFlow += pathFlow;
    }
    return maxFlow;
  }

  List<String> edmonds_karp_steps() {
    int maxFlow = 0;
    int source = 1; // Источник (start)
    int sink = 11;
    List<String> steps = [];

    // Создание копии графа
    Map<int, Map<int, int>> copy = {};
    w_graph.forEach((key, value) {
      copy[key] = Map<int, int>.from(value);
    });

    List<int> parent = List.filled(w_graph.length + 1, -1);

    while (bfs(copy, source, sink, parent)) {
      int pathFlow = 10 ^ 6;
      String step = "";

      // Найти минимальный поток в найденном пути
      int v = sink;
      while (v != source) {
        int u = parent[v];
        pathFlow = min(pathFlow, copy[u]![v]!);
        v = parent[v];
      }

      // Обновить емкости ребер и обратных ребер
      v = sink;
      while (v != source) {
        int u = parent[v];
        copy[u]![v] = copy[u]![v]! - pathFlow;
        if (copy.containsKey(v) && copy[v]!.containsKey(u)) {
          copy[v]![u] = copy[v]![u]! + pathFlow;
        } else {
          if (!copy.containsKey(v)) {
            copy[v] = {};
          }
          copy[v]![u] = pathFlow;
        }
        v = parent[v];
      }

      maxFlow += pathFlow;

      // Формирование шага
      step += "Текущий максимальный поток: $maxFlow\n";
      step += "Путь: ";
      int node = sink;
      while (node != source) {
        step += "$node <- ";
        node = parent[node];
      }
      step += "$source\n";
      step += "Добавленный поток: $pathFlow\n";
      steps.add(step);
    }

    return steps;
  }
}
