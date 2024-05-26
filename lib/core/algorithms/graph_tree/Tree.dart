import './Node.dart';
import 'dart:math';

abstract class Tree {
  Node? head;
  var size = 0;

  Tree() {
    generate_tree();
  }

  void generate_tree() {
    var rand = Random();
    this.size = rand.nextInt(3) + 8;
    this.head = Node(size / 2 + 1);
  }

  void fill_tree();
}
