import 'dart:collection';
import 'dart:math';
import 'Tree.dart';
import 'Node.dart';

import 'dart:collection';
import 'dart:math';

class NonBinaryTree extends Tree {
  @override
  void fill_tree() {
    generate_tree();
    var rand = Random();
    head = Node(nodes.removeAt(0));
    List<Node?> queue = [head];
    while (nodes.isNotEmpty) {
      Node? current = queue.removeAt(0);
      int childCount = rand.nextInt(2) + 1; // Количество детей от 1 до 2
      current?.childs = List.filled(childCount, null);
      for (int i = 0; i < childCount && nodes.isNotEmpty; i++) {
        Node newNode = Node(nodes.removeAt(0));
        print(newNode.name);
        current?.childs[i] = newNode;
        queue.add(newNode);
      }
    }
  }

  @override
  void print_tree(Node? curr) {
    if (curr == null) return;
    print("\nparent - ${curr.name}, childs: ");
    for (var child in curr.childs) {
      print(child?.name);
    }
    for (var child in curr.childs) {
      print_tree(child);
    }
  }

  // Новый метод для генерации кода Прюфера
  String generatePruferCode() {
    if (head == null) {
      return "";
    }

    Map<int, List<Node?>> adjList = {};
    _createAdjList(head, adjList);

    int n = adjList.length;
    List<int> degree = List.filled(n + 1, 0);
    for (int i = 1; i <= n; i++) {
      if (adjList[i] != null) {
        degree[i] = adjList[i]!.length;
      }
    }

    Queue<int> leafQueue = Queue();
    for (int i = 1; i <= n; i++) {
      if (degree[i] == 1) {
        leafQueue.add(i);
      }
    }

    List<int> pruferCode = [];
    for (int i = 0; i < n - 2; i++) {
      int leaf = leafQueue.removeFirst();
      int parent = _findParent(leaf, adjList);
      pruferCode.add(parent);

      degree[parent]--;
      if (degree[parent] == 1) {
        leafQueue.add(parent);
      }
    }

    return pruferCode.join(" ");
  }

  void _createAdjList(Node? node, Map<int, List<Node?>> adjList) {
    if (node == null) return;
    if (!adjList.containsKey(node.name)) {
      adjList[node.name] = [];
    }
    for (Node? child in node.childs) {
      if (child != null) {
        adjList[node.name]!.add(child);
        if (!adjList.containsKey(child.name)) {
          adjList[child.name] = [];
        }
        adjList[child.name]!.add(node);
        _createAdjList(child, adjList);
      }
    }
  }

  int _findParent(int leaf, Map<int, List<Node?>> adjList) {
    for (Node? node in adjList[leaf]!) {
      if (node != null) {
        return node.name;
      }
    }
    return -1; // should never happen
  }

  // Новый метод для нахождения радиуса, диаметра и центра(ов)
  Map<String, dynamic> calculateTreeProperties() {
    if (head == null) {
      return {};
    }

    Map<int, List<Node?>> adjList = {};
    _createAdjList(head, adjList);

    // Первый BFS для нахождения самого удаленного узла (A)
    var firstBfs = _bfs(1, adjList);
    var farthestNodeA = firstBfs['farthestNode'];
    var distancesA = firstBfs['distances'];

    // Второй BFS для нахождения другого самого удаленного узла (B)
    var secondBfs = _bfs(farthestNodeA, adjList);
    var diameter = secondBfs['maxDistance'];
    var farthestNodeB = secondBfs['farthestNode'];
    var distancesB = secondBfs['distances'];

    // Радиус - это половина диаметра (округленная вверх)
    var radius = (diameter / 2).ceil();

    // Центры - узлы, у которых расстояние до самого удаленного узла (B) равно радиусу
    var centers = [];
    for (var node in distancesB.keys) {
      if (distancesB[node] == radius) {
        centers.add(node);
      }
    }

    return {'diameter': diameter, 'radius': radius, 'centers': centers};
  }

  Map<String, dynamic> _bfs(int start, Map<int, List<Node?>> adjList) {
    Map<int, int> distances = {};
    Queue<int> queue = Queue();
    queue.add(start);
    distances[start] = 0;

    int farthestNode = start;
    int maxDistance = 0;
    while (queue.isNotEmpty) {
      int node = queue.removeFirst();
      for (var neighbor in adjList[node]!) {
        if (!distances.containsKey(neighbor!.name)) {
          distances[neighbor.name] = distances[node]! + 1;
          queue.add(neighbor.name);
          if (distances[neighbor.name]! > maxDistance) {
            maxDistance = distances[neighbor.name]!;
            farthestNode = neighbor.name;
          }
        }
      }
    }

    return {
      'farthestNode': farthestNode,
      'maxDistance': maxDistance,
      'distances': distances
    };
  }
}


// import 'dart:collection';
// import 'dart:math';

// class TreeGenerator {
//   Map<int, Set<int>> treeData = {};

//   TreeGenerator() {
//     generateTree();
//   }

//   void generateTree() {
//     var rng = Random();
//     var allVertices = List.generate(
//         11, (index) => index + 1); // Создаем список всех возможных вершин

//     // Начинаем с центральной вершины
//     int centralVertex = 1;
//     treeData[centralVertex] = <int>{};

//     // Добавляем первую ветвь к центральной вершине
//     addBranch(rng, centralVertex, allVertices, treeData);

//     // Удаляем центральную вершину из списка всех вершин, так как она уже была обработана
//     allVertices.remove(centralVertex);

//     // Продолжаем добавлять ветви до тех пор, пока все вершины не будут использованы
//     while (allVertices.isNotEmpty) {
//       int newParent = rng.nextInt(allVertices.length) +
//           1; // Выбираем случайную вершину из оставшихся
//       addBranch(rng, newParent, allVertices, treeData);
//       allVertices.remove(newParent); // Удаляем использованную вершину из списка
//     }
//   }

//   void addBranch(Random rng, int parent, List<int> remainingVertices,
//       Map<int, Set<int>> treeData) {
//     int child = remainingVertices[
//         rng.nextInt(remainingVertices.length)]; // Выбираем случайного ребенка
//     treeData[parent]?.add(child); // Добавляем ребро от родителя к ребенку
//     treeData[child] = <int>{
//       parent
//     }; // Добавляем ребенка в дерево как потомка родителя
//     remainingVertices
//         .remove(child); // Удаляем использованного ребенка из списка
//   }

//   Map<int, Set<int>> getTree() {
//     return treeData;
//   }
// }
