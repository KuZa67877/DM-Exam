import 'dart:collection';
import 'dart:math';

import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';

abstract class GraphTaskInterface {
  final MyGraph graph;
  late List<String> answer;

  GraphTaskInterface({required this.graph, required this.answer});

  void generateVariant();
  String writeQuestion();
}

class GraphAnalysis {
  final MyGraph graph;

  GraphAnalysis(this.graph);

  // Вычисление радиуса графа
  int calculateRadius() {
    int radius = 0;
    for (int vertex in graph.graph.keys) {
      int distance = bfs(vertex);
      radius = max(radius, distance);
    }
    return radius;
  }

  // Вычисление диаметра графа
  int calculateDiameter() {
    int diameter = 0;
    for (int vertex in graph.graph.keys) {
      int distance = bfs(vertex);
      diameter = max(diameter, distance);
    }
    return diameter;
  }

  // Поиск ближайшей вершины к заданной
  int bfs(int startVertex) {
    Queue<int> queue = Queue<int>();
    Map<int, int> distances = {startVertex: 0};
    queue.add(startVertex);

    while (!queue.isEmpty) {
      int currentVertex = queue.removeFirst();
      for (int neighbor in graph.graph[currentVertex]!) {
        if (!distances.containsKey(neighbor)) {
          distances[neighbor] = distances[currentVertex]! + 1;
          queue.add(neighbor);
        }
      }
    }

    return distances.values.reduce(max);
  }

  // Вычисление центра графа
  int? calculateCenter() {
    int minDegree = 1000000;
    int centerVertex = -1;
    for (int vertex in graph.graph.keys) {
      int degree = graph.graph[vertex]!.length;
      if (degree < minDegree) {
        minDegree = degree;
        centerVertex = vertex;
      }
    }
    return centerVertex;
  }
}

class PrueferCodeGenerator {
  static String generatePrueferCodeAsString(Map<int, Set<int>> graph) {
    // Инициализация переменных для обхода графа
    final visited = Set<int>();
    final order = Queue<int>();

    // Функция для обхода графа в глубину
    void dfs(int vertex) {
      visited.add(vertex);
      for (final neighbor in graph[vertex]!) {
        if (!visited.contains(neighbor)) {
          dfs(neighbor);
        }
      }
      order.addLast(
          vertex); // Добавляем вершину в конец очереди после посещения всех её соседей
    }

    // Обходим граф в глубину
    for (final vertex in graph.keys) {
      if (!visited.contains(vertex)) {
        dfs(vertex);
      }
    }

    // Генерируем код Прюфера как строку
    final prueferCodeList = <int>[];
    while (order.isNotEmpty) {
      final vertex = order.removeFirst();
      prueferCodeList.add(vertex);
      if (vertex == 1) break; // Выходим из цикла, если достигли первой вершины
    }

    // Преобразуем список в строку
    return prueferCodeList.join(' ');
  }
}

class Stack<T> {
  List<T> elements = [];

  void push(T item) {
    elements.add(item);
  }

  T pop() {
    return elements.removeAt(elements.length - 1);
  }

  bool isEmpty() {
    return elements.isEmpty;
  }
}

class GraphTraversal {
  static String dfsTraversal(Map<int, Set<int>> graph, int startVertex) {
    final visited = Set<int>();
    final stack = Stack<int>();
    final result = StringBuffer();

    stack.push(startVertex);
    while (!stack.isEmpty()) {
      final currentVertex = stack.pop();
      if (!visited.contains(currentVertex)) {
        visited.add(currentVertex);
        result.write('$currentVertex ');
        for (final neighbor in graph[currentVertex]!) {
          stack.push(neighbor);
        }
      }
    }

    return result.toString().trim();
  }

  static String bfsTraversal(Map<int, Set<int>> graph, int startVertex) {
    final visited = Set<int>();
    final queue = Queue<int>();
    final result = StringBuffer();

    queue.add(startVertex);
    while (queue.isNotEmpty) {
      final currentVertex = queue.removeFirst();
      if (!visited.contains(currentVertex)) {
        visited.add(currentVertex);
        result.write('$currentVertex ');
        for (final neighbor in graph[currentVertex]!) {
          queue.add(neighbor);
        }
      }
    }

    return result.toString().trim();
  }
}
