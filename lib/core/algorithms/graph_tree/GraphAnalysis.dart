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
