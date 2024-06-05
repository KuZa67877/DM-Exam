import 'dart:collection';
import 'dart:math';

import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';

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

class TreeAnalysis {
  final Node treeRoot;

  TreeAnalysis(this.treeRoot);

  // Вычисление радиуса дерева
  int calculateRadius() {
    int radius = 0;
    _forEachNode((Node node) {
      int distance = _maxDistanceFromNode(node);
      radius = max(radius, distance);
    });
    return radius;
  }

  // Вычисление диаметра дерева
  int calculateDiameter() {
    int diameter = 0;
    _forEachNode((Node node) {
      int distance = _maxDistanceFromNode(node);
      diameter = max(diameter, distance);
    });
    return diameter;
  }

  // Поиск максимального расстояния от данной вершины
  int _maxDistanceFromNode(Node startNode) {
    Queue<Node> queue = Queue<Node>();
    Map<Node, int> distances = {startNode: 0};
    queue.add(startNode);

    while (queue.isNotEmpty) {
      Node currentNode = queue.removeFirst();
      for (Node? neighbor in currentNode.childs) {
        if (neighbor != null && !distances.containsKey(neighbor)) {
          distances[neighbor] = distances[currentNode]! + 1;
          queue.add(neighbor);
        }
      }
    }

    return distances.values.reduce(max);
  }

  // Вычисление центра дерева
  Node? calculateCenter() {
    int minDegree = 1000000;
    Node? centerNode;
    _forEachNode((Node node) {
      int degree = node.childs.length;
      if (degree < minDegree) {
        minDegree = degree;
        centerNode = node;
      }
    });
    return centerNode;
  }

  // Обход всех узлов дерева
  void _forEachNode(void Function(Node) action) {
    Set<Node> visited = {};
    void _dfs(Node node) {
      if (visited.contains(node)) return;
      visited.add(node);
      action(node);
      for (Node? child in node.childs) {
        if (child != null) _dfs(child);
      }
    }

    _dfs(treeRoot);
  }
}

class PrueferCodeTreeGenerator {
  static String generatePrueferCodeAsString(Node treeRoot) {
    if (treeRoot.childs.isEmpty) return '';
    List<int> prueferCode = [];
    Map<Node, int> degree = {};

    // Инициализируем степени всех узлов
    void _initializeDegrees(Node node) {
      degree[node] = node.childs.length;
      for (Node? child in node.childs) {
        if (child != null) _initializeDegrees(child);
      }
    }

    _initializeDegrees(treeRoot);

    List<Node> leaves = degree.keys.where((node) => degree[node] == 1).toList();
    leaves.sort((a, b) => a.name.compareTo(b.name));

    for (int i = 0; i < degree.length - 2; i++) {
      Node leaf = leaves.removeAt(0);
      for (Node? neighbor in leaf.childs) {
        if (neighbor != null && degree.containsKey(neighbor)) {
          prueferCode.add(neighbor.name);
          degree[neighbor] = degree[neighbor]! - 1;
          if (degree[neighbor] == 1) {
            leaves.add(neighbor);
            leaves.sort((a, b) => a.name.compareTo(b.name));
          }
          break;
        }
      }
      degree.remove(leaf);
    }

    return prueferCode.join(' ');
  }
}
