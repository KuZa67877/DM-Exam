import 'dart:math';
import 'dart:ui';
import 'package:dmiti_project/core/algorithms/graph_tree/GraphWeightPath.dart';
import 'package:dmiti_project/res/colors.dart'; // Импорт цветов
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class GraphLittlePathWidget extends StatelessWidget {
  final GraphWeightPath graphWeight;
  GraphLittlePathWidget({Key? key, required this.graphWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(graphWeight.w_graph, graphWeight.vertex_weights),
      child: Container(),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, Map<int, int>> graph;
  final Map<int, int> weights;
  final double radius = 15.0; // Радиус вершин
  final double padding = 150.0; // Расстояние между вершинами

  GraphPainter(this.graph, this.weights);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Позиции вершин в форме пятиугольника
    final vertices = [
      Offset(centerX, centerY - 120),
      Offset(centerX - padding, centerY + 0),
      Offset(centerX + padding, centerY),
      Offset(centerX - 100, centerY + 150),
      Offset(centerX + 160, centerY + 150),
    ];

    for (final vertex in graph.keys) {
      final edges = graph[vertex] ?? {};
      for (final edge in edges.keys) {
        final start = vertices[vertex - 1]; // Индексируем вершины, начиная с 1
        final end = vertices[edge - 1];

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
        final middle = ((startAdjusted + endAdjusted) / 2)
            .translate(-radius / 2, -radius / 2);
        final weightText = edges[edge].toString(); // Используем вес ребра
        final weightTextSpan =
            TextSpan(text: weightText, style: getTheme().textTheme.labelLarge);
        final weightTextPainter = TextPainter(
            text: weightTextSpan,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center);
        weightTextPainter.layout(maxWidth: radius * 2);
        weightTextPainter.paint(canvas, middle);
      }
    }

    for (int i = 0; i < vertices.length; i++) {
      canvas.drawCircle(vertices[i], radius, paint);

      final text = (i + 1).toString(); // Индексируем вершины, начиная с 1
      final textSpan =
          TextSpan(style: TextStyle(color: Colors.white), text: text);
      final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainter.layout(maxWidth: radius * 2);
      textPainter.paint(
          canvas, vertices[i].translate(-radius / 2, -radius / 2));
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
