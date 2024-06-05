import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/NonBinaryTree.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

class TreePainterWidget extends StatelessWidget {
  final NonBinaryTree tree;

  TreePainterWidget({required this.tree});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TreePainter(tree.head, context),
      child: Container(),
    );
  }
}

class TreePainter extends CustomPainter {
  final Node? treeRoot;
  final BuildContext context;
  late bool isEdgeBlack;

  TreePainter(this.treeRoot, this.context, {this.isEdgeBlack = false});

  @override
  void paint(Canvas canvas, Size size) {
    if (treeRoot == null) {
      return;
    }

    final paint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;

    final radius = 15.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Отображаем позиции вершин дерева
    final Map<Node, Offset> nodePositions = {};
    _calculateNodePositions(
        treeRoot!, size.width, size.height / 2, nodePositions);

    // Рисуем ребра
    _drawEdges(canvas, treeRoot!, nodePositions);

    // Рисуем вершины
    _drawNodes(canvas, nodePositions, radius, paint);
  }

  void _calculateNodePositions(
      Node node, double width, double height, Map<Node, Offset> positions) {
    List<Node> nodes = [];
    _collectNodes(node, nodes);

    int nodeCount = nodes.length;
    int half = (nodeCount / 2).ceil();
    double stepX = width / (half + 1);

    for (int i = 0; i < half; i++) {
      positions[nodes[i]] = Offset(stepX * (i + 1), height - 40);
    }
    for (int i = half; i < nodeCount; i++) {
      positions[nodes[i]] = Offset(stepX * (i - half + 1), height + 40);
    }
  }

  void _collectNodes(Node node, List<Node> nodes) {
    nodes.add(node);
    for (var child in node.childs) {
      if (child != null) {
        _collectNodes(child, nodes);
      }
    }
  }

  void _drawEdges(Canvas canvas, Node node, Map<Node, Offset> positions) {
    final paint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Offset? startPosition = positions[node];
    if (startPosition != null) {
      for (var child in node.childs) {
        if (child != null) {
          Offset? endPosition = positions[child];
          if (endPosition != null) {
            canvas.drawLine(startPosition, endPosition, paint);
          }
          _drawEdges(canvas, child, positions);
        }
      }
    }
  }

  void _drawNodes(
      Canvas canvas, Map<Node, Offset> positions, double radius, Paint paint) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 12);
    positions.forEach((node, position) {
      canvas.drawCircle(position, radius, paint);

      final textSpan = TextSpan(text: node.name.toString(), style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(maxWidth: radius * 2);
      textPainter.paint(
          canvas, Offset(position.dx - radius / 2, position.dy - radius / 2));
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
//TODO - сохранил на случай того, если нужно будет визуализировать дерево для обхода (чтобы оно было в высоту)
// import 'dart:math';
// import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';
// import 'package:dmiti_project/core/algorithms/graph_tree/NonBinaryTree.dart';
// import 'package:dmiti_project/res/colors.dart';
// import 'package:flutter/material.dart';

// class TreePainterWidget extends StatelessWidget {
//   final NonBinaryTree tree;

//   TreePainterWidget({required this.tree});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TreePainter(tree.head, context),
//       child: Container(),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final Node? treeRoot;
//   final BuildContext context;
//   late bool isEdgeBlack;

//   TreePainter(this.treeRoot, this.context, {this.isEdgeBlack = false});

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (treeRoot == null) {
//       return;
//     }

//     final paint = Paint()
//       ..color = AppColors.green
//       ..style = PaintingStyle.fill;

//     final radius = 15.0;
//     final centerX = size.width / 2;
//     final centerY = size.height / 2;

//     // Отображаем позиции вершин дерева
//     final Map<Node, Offset> nodePositions = {};
//     _calculateNodePositions(
//         treeRoot!, centerX, centerY, size.width / 2, nodePositions);

//     // Рисуем ребра
//     _drawEdges(canvas, treeRoot!, nodePositions);

//     // Рисуем вершины
//     _drawNodes(canvas, nodePositions, radius, paint);
//   }

//   void _calculateNodePositions(Node node, double x, double y, double offsetX,
//       Map<Node, Offset> positions,
//       [double offsetY = 100]) {
//     positions[node] = Offset(x, y);
//     if (node.childs.isNotEmpty) {
//       double stepX = offsetX / (node.childs.length + 1);
//       double startX = x - (node.childs.length * stepX / 2);
//       for (int i = 0; i < node.childs.length; i++) {
//         if (node.childs[i] != null) {
//           _calculateNodePositions(node.childs[i]!, startX + i * stepX,
//               y + offsetY, offsetX / 2, positions, offsetY);
//         }
//       }
//     }
//   }

//   void _drawEdges(Canvas canvas, Node node, Map<Node, Offset> positions) {
//     final paint = Paint()
//       ..color = AppColors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     Offset? startPosition = positions[node];
//     if (startPosition != null) {
//       for (var child in node.childs) {
//         if (child != null) {
//           Offset? endPosition = positions[child];
//           if (endPosition != null) {
//             canvas.drawLine(startPosition, endPosition, paint);
//           }
//           _drawEdges(canvas, child, positions);
//         }
//       }
//     }
//   }

//   void _drawNodes(
//       Canvas canvas, Map<Node, Offset> positions, double radius, Paint paint) {
//     final textStyle = TextStyle(color: Colors.white, fontSize: 12);
//     positions.forEach((node, position) {
//       canvas.drawCircle(position, radius, paint);

//       final textSpan = TextSpan(text: node.name.toString(), style: textStyle);
//       final textPainter = TextPainter(
//         text: textSpan,
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center,
//       );
//       textPainter.layout(maxWidth: radius * 2);
//       textPainter.paint(
//           canvas, Offset(position.dx - radius / 2, position.dy - radius / 2));
//     });
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
