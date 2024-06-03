import 'dart:math';
import 'Tree.dart';
import 'Node.dart';

class NonBinaryTree extends Tree
{
  @override
  void fill_tree() 
  {
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
  void print_tree(Node? curr) 
  {
    if(curr==null) return;
    print("\nparent - ${curr.name}, childs: ");
    for(var child in curr.childs)
    {
      print(child?.name);
    }
    for (var child in curr.childs)
    {
      print_tree(child);
    }
  }
}