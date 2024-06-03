import 'package:dmiti_project/core/algorithms/graph_tree/BinaryTree.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/DirectedRandGraph.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphAnalysis.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/UndirectedSmallGraph.dart';
import 'package:flutter/material.dart';

import '../../app/bottom_navigation_bar_widget.dart';

void main() {
  // final BinaryTree myTree = BinaryTree();
  // print(myTree.head?.childs ?? 100000);
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
