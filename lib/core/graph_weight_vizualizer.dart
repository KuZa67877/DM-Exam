import 'dart:math';
import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

class GraphWeightWidget extends StatelessWidget {
  final Map<int, Set<int>> graph;
  final Map<int, int> weights;

  GraphWeightWidget({required this.graph, required this.weights});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(graph, weights, context),
      child: Container(),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, Set<int>> graph;
  final Map<int, int> weights;
  final BuildContext context;
  late bool isEdgeBlack;

  GraphPainter(this.graph, this.weights, this.context,
      {this.isEdgeBlack = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final radius = 15.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final vertexPositions = {
      1: Offset(centerX - 180, centerY),
      2: Offset(centerX - 90, centerY - 100),
      3: Offset(centerX - 90, centerY),
      4: Offset(centerX - 90, centerY + 100),
      5: Offset(centerX, centerY - 100),
      6: Offset(centerX, centerY),
      7: Offset(centerX, centerY + 100),
      8: Offset(centerX + 50, centerY - 100),
      9: Offset(centerX + 50, centerY),
      10: Offset(centerX + 50, centerY + 100),
      11: Offset(centerX + 120, centerY - 100),
      12: Offset(centerX + 120, centerY),
      13: Offset(centerX + 120, centerY + 100),
      14: Offset(centerX + 180, centerY),
    };

    for (final vertex in graph.keys) {
      final edges = graph[vertex] ?? {};
      for (final edge in edges) {
        final start = vertexPositions[vertex]!;
        final end = vertexPositions[edge]!;

        final angle = atan2(end.dy - start.dy, end.dx - start.dx);
        final startAdjusted = Offset(
          start.dx + radius * cos(angle),
          start.dy + radius * sin(angle),
        );
        final endAdjusted = Offset(
          end.dx - radius * cos(angle),
          end.dy - radius * sin(angle),
        );

        canvas.drawLine(
          startAdjusted,
          endAdjusted,
          Paint()
            ..color = AppColors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0,
        );
        // Рисуем стрелку
        drawArrow(canvas, startAdjusted, endAdjusted);

        // Рисуем вес ребра
        final middle = Offset(
          (startAdjusted.dx + endAdjusted.dx) / 2,
          (startAdjusted.dy + endAdjusted.dy) / 2,
        );
        final weightText = weights[edge].toString();
        final weightTextSpan =
            TextSpan(text: weightText, style: TextStyle(color: Colors.red));
        final weightTextPainter = TextPainter(
          text: weightTextSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        );
        weightTextPainter.layout(maxWidth: radius * 2);
        weightTextPainter.paint(
            canvas, Offset(middle.dx - radius / 2, middle.dy - radius / 2));
      }
    }

    for (int i = 1; i <= vertexPositions.length; i++) {
      final position = vertexPositions[i]!;
      canvas.drawCircle(position, radius, paint);

      final text = i.toString();
      final textSpan =
          TextSpan(text: text, style: TextStyle(color: Colors.white));
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout(maxWidth: radius * 2);
      textPainter.paint(
          canvas, Offset(position.dx - radius / 2, position.dy - radius / 2));
    }
  }

  void drawArrow(Canvas canvas, Offset start, Offset end) {
    final paint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final arrowSize = 10.0;
    final angle = atan2(end.dy - start.dy, end.dx - start.dx);

    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * cos(angle - pi / 6),
      end.dy - arrowSize * sin(angle - pi / 6),
    );
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * cos(angle + pi / 6),
      end.dy - arrowSize * sin(angle + pi / 6),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
