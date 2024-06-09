import './Node.dart';
import './Tree.dart';
import 'dart:collection';

class BinaryTree extends Tree {
  @override
  void fill_tree() {
    generate_tree();
    head = buildBalancedTree(nodes, 0, nodes.length - 1);
  }

  Node? buildBalancedTree(List<int> nodes, int start, int end) {
    if (start > end) {
      return null;
    }
    int mid = (start + end) ~/ 2;
    Node node = Node(nodes[mid]);
    node.childs = [null, null];
    node.childs[0] = buildBalancedTree(nodes, start, mid - 1);
    node.childs[1] = buildBalancedTree(nodes, mid + 1, end);
    return node;
  }

  Node balance(Node root) {
    int balanceFactor = get_balance(root);

    if (balanceFactor > 1) {
      if (get_balance(root.childs[1]) < 0) {
        root.childs[1] = turn_right(root.childs[1]!);
      }
      return turn_left(root);
    }

    if (balanceFactor < -1) {
      if (get_balance(root.childs[0]) > 0) {
        root.childs[0] = turn_left(root.childs[0]!);
      }
      return turn_right(root);
    }

    return root;
  }

  int get_balance(Node? node) {
    if (node == null) return 0;
    return (node.childs[1]?.height ?? 0) - (node.childs[0]?.height ?? 0);
  }

  Node turn_right(Node root) {
    Node nodeL = root.childs[0]!;
    root.childs[0] = nodeL.childs[1];
    nodeL.childs[1] = root;
    return nodeL;
  }

  Node turn_left(Node root) {
    Node nodeR = root.childs[1]!;
    root.childs[1] = nodeR.childs[0];
    nodeR.childs[0] = root;
    return nodeR;
  }

  @override
  void print_tree(Node? curr) {
    if (curr != null) {
      print_tree(curr.childs[0]);
      print(curr.name);
      print_tree(curr.childs[1]);
    }
  }

  // Метод обхода в глубину (DFS)
  String dfs(Node? node) {
    if (node == null) return '';
    String result = node.name.toString();
    if (node.childs[0] != null) {
      result += ' ' + dfs(node.childs[0]);
    }
    if (node.childs[1] != null) {
      result += ' ' + dfs(node.childs[1]);
    }
    return result;
  }

  // Метод обхода в ширину (BFS)
  String bfs(Node? root) {
    if (root == null) return '';
    Queue<Node?> queue = Queue<Node?>();
    queue.add(root);
    String result = '';

    while (queue.isNotEmpty) {
      Node? node = queue.removeFirst();
      if (node != null) {
        result += node.name.toString() + ' ';
        if (node.childs[0] != null) queue.add(node.childs[0]);
        if (node.childs[1] != null) queue.add(node.childs[1]);
      }
    }
    return result.trim();
  }

  List<String> bfs_steps(Node? root) {
    if (root == null) return [];
    Queue<Node?> queue = Queue<Node?>();
    queue.add(root);
    List<String> steps = [];

    while (queue.isNotEmpty) {
      Node? node = queue.removeFirst();
      if (node != null) {
        steps.add("Посещаем узел: ${node.name}");
        if (node.childs[0] != null) queue.add(node.childs[0]);
        if (node.childs[1] != null) queue.add(node.childs[1]);
      }
    }
    return steps;
  }

  List<String> dfs_steps(Node? node) {
    List<String> steps = [];
    _dfs_helper(node, steps);
    return steps;
  }

  void _dfs_helper(Node? node, List<String> steps) {
    if (node == null) return;
    steps.add("Посещаем узел: ${node.name}");
    if (node.childs[0] != null) {
      _dfs_helper(node.childs[0], steps);
    }
    if (node.childs[1] != null) {
      _dfs_helper(node.childs[1], steps);
    }
  }
}
