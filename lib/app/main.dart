import 'package:dmiti_project/core/algorithms/graph_tree/BinaryTree.dart';
import 'package:flutter/material.dart';

import '../../app/bottom_navigation_bar_widget.dart';

void main() {
  BinaryTree myTree = BinaryTree();
  myTree.print_tree(myTree.head);

  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO бекграунд калор на белый обратно поставить
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarWidget(),
    );
  }
}
