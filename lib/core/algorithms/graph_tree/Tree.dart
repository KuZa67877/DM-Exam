import './Node.dart';
import 'dart:math';

abstract class Tree {
  Node? head;
  var size = 0;
  List<int> nodes = [];

  Tree() 
  {
    fill_tree();
  }

  void generate_tree() 
  {
    var rand = Random();
    this.size = rand.nextInt(3) + 9;
    this.nodes = List<int>.generate(this.size, (index) => index + 1);
  }

  void fill_tree();

  void print_tree(Node curr);
}
