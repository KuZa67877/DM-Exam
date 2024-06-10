import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

import '../algorithms/graph_tree/Graphs.dart';

class GraphDiametrWidget extends StatelessWidget {
  final MyGraph graph;

  GraphDiametrWidget({required this.graph});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(graph.graph),
      child: Container(),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, Set<int>> graph;
  final double radius = 20.0;
  final double padding = 100.0;

  GraphPainter(this.graph);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;

    final edgePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final vertexPositions = {
      1: Offset(centerX - 150, centerY - padding),
      2: Offset(centerX - 50, centerY - padding),
      3: Offset(centerX + 50, centerY - padding),
      4: Offset(centerX + 150, centerY - padding),
      5: Offset(centerX - 150, centerY),
      6: Offset(centerX - 50, centerY),
      7: Offset(centerX + 50, centerY),
      8: Offset(centerX + 150, centerY),
      9: Offset(centerX - 150, centerY + padding),
      10: Offset(centerX - 50, centerY + padding),
      11: Offset(centerX + 50, centerY + padding),
      12: Offset(centerX + 150, centerY + padding),
    };

    for (final vertex in graph.keys) {
      final start = vertexPositions[vertex]!;
      for (final neighbor in graph[vertex]!) {
        final end = vertexPositions[neighbor]!;
        canvas.drawLine(start, end, edgePaint);
      }
    }

    for (int i = 1; i <= vertexPositions.length; i++) {
      final position = vertexPositions[i]!;
      canvas.drawCircle(position, radius, paint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        position.translate(-textPainter.width / 2, -textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
