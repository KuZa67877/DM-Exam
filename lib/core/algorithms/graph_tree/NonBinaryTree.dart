import 'dart:collection';
import 'dart:math';
import 'Tree.dart';
import 'Node.dart';

class NonBinaryTree extends Tree {
  int maxDepth = 4; // Максимальная глубина дерева

  @override
  void fill_tree() {
    generate_tree();
    var rand = Random();
    head = Node(nodes.removeAt(0));
    List<Map<String, dynamic>> queue = [
      {'node': head, 'depth': 1}
    ];
    while (nodes.isNotEmpty && queue.isNotEmpty) {
      var current = queue.removeAt(0);
      Node? currentNode = current['node'];
      int currentDepth = current['depth'];

      if (currentDepth < maxDepth) {
        int childCount = rand.nextInt(3) + 2; // Количество детей от 2 до 4
        currentNode?.childs = List.filled(childCount, null);
        for (int i = 0; i < childCount && nodes.isNotEmpty; i++) {
          Node newNode = Node(nodes.removeAt(0));
          print(newNode.name);
          currentNode?.childs[i] = newNode;
          queue.add({'node': newNode, 'depth': currentDepth + 1});
        }
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

  List<String> generatePruferCodeSteps() {
    List<String> steps = [];
    if (head == null) {
      return steps;
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

      steps.add("Удаляем лист ${leaf} с родителем ${parent}");
      degree[parent]--;
      if (degree[parent] == 1) {
        leafQueue.add(parent);
      }
    }

    steps.add("Полученный код Прюфера: ${pruferCode.join(" ")}");
    return steps;
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

    var firstBfs = _bfs(1, adjList);
    var farthestNodeA = firstBfs['farthestNode'];
    var distancesA = firstBfs['distances'];

    var secondBfs = _bfs(farthestNodeA, adjList);
    var diameter = secondBfs['maxDistance'];
    var farthestNodeB = secondBfs['farthestNode'];
    var distancesB = secondBfs['distances'];

    var radius = (diameter / 2).ceil();

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

  // Метод для пошагового нахождения радиуса, диаметра и центра(ов)
  List<String> calculateTreePropertiesSteps() {
    List<String> steps = [];
    if (head == null) {
      return steps;
    }

    Map<int, List<Node?>> adjList = {};
    _createAdjList(head, adjList);

    var firstBfs = _bfs(1, adjList);
    var farthestNodeA = firstBfs['farthestNode'];
    var distancesA = firstBfs['distances'];

    steps.add(
        "Выполняем первый BFS от корня дерева: найдена дальняя вершина $farthestNodeA");

    var secondBfs = _bfs(farthestNodeA, adjList);
    var diameter = secondBfs['maxDistance'];
    var farthestNodeB = secondBfs['farthestNode'];
    var distancesB = secondBfs['distances'];

    steps.add(
        "Выполняем второй BFS от вершины $farthestNodeA: найдена дальняя вершина $farthestNodeB и вычислен диаметр $diameter");

    var radius = (diameter / 2).ceil();
    steps.add("Радиус дерева равен $radius");

    var centers = [];
    for (var node in distancesB.keys) {
      if (distancesB[node] == radius) {
        centers.add(node);
      }
    }

    steps.add("Центральные вершины дерева: ${centers.join(', ')}");

    return steps;
  }
}
