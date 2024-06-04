import 'dart:math';
import 'dart:ui';
import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';
import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  final Node? head;

  TreeWidget({required this.head});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TreePainter(head),
      child: Container(),
    );
  }
}

class TreePainter extends CustomPainter {
  final Node? head;

  TreePainter(this.head);

  @override
  void paint(Canvas canvas, Size size) {
    if (head == null) return;

    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final radius = 15.0;

    // Define positions for nodes (manual layout based on the provided image)
    final positions = <int, Offset>{
      1: Offset(50, 50),
      2: Offset(100, 50),
      3: Offset(150, 50),
      4: Offset(200, 50),
      5: Offset(250, 50),
      6: Offset(300, 50),
      7: Offset(50, 100),
      8: Offset(100, 100),
      9: Offset(150, 100),
      10: Offset(200, 100),
      11: Offset(250, 100),
    };

    void drawNode(Node? node, Offset offset) {
      if (node == null) return;

      canvas.drawCircle(offset, radius, paint);
      final textSpan = TextSpan(
        text: node.name.toString(),
        style: TextStyle(color: Colors.white),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: radius * 2);
      textPainter.paint(
          canvas, Offset(offset.dx - radius / 2, offset.dy - radius / 2));

      for (var i = 0; i < node.childs.length; i++) {
        final child = node.childs[i];
        if (child != null) {
          final childPos = positions[child.name];
          if (childPos != null) {
            canvas.drawLine(
                offset,
                childPos,
                Paint()
                  ..color = Colors.black
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2.0);
            drawNode(child, childPos);
          }
        }
      }
    }

    if (positions.containsKey(head!.name)) {
      drawNode(head, positions[head!.name]!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
