import 'dart:math';
import 'Tree.dart';
import 'Node.dart';

class NonBinaryTree extends Tree {
  @override
  void fill_tree() {
    generate_tree();
    var rand = Random();
    head = Node(nodes.removeAt(0));
    List<Node?> queue = [head];
    while (nodes.isNotEmpty) {
      Node? current = queue.removeAt(0);
      int childCount = rand.nextInt(3) + 1; // Количество детей от 1 до 3
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
