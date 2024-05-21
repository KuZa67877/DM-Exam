import 'dart:math';
import 'dart:ui';
import 'package:dmiti_project/core/algorithms/graph_tree/Graphs.dart';
import 'package:dmiti_project/core/algorithms/graph_tree/Tree.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final Map<int, Set<int>> graph;

  GraphWidget({required this.graph});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(graph, context),
      child: Container(),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, Set<int>> graph;
  final BuildContext context;
  late bool isEdgeBlack; // Добавляем флаг для управления цветом ребер

  GraphPainter(this.graph, this.context,
      {this.isEdgeBlack = false}); // Изменяем конструктор

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green // Цвет вершин
      ..style = PaintingStyle.fill;

    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final radius = 15.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Расчет угла для каждого вершины
    final angleStep = 2 * pi / graph.length;
    final angles =
        List<double>.generate(graph.length, (index) => index * angleStep);

    isEdgeBlack = true;
    // Рисуем ребра
    for (final vertex in graph.keys) {
      final edges = graph[vertex];
      for (final edge in edges!) {
        final angle1 = angles[vertex - 1];
        final angle2 = angles[edge - 1];
        final x1 = centerX + radius * cos(angle1) * 10;
        final y1 = centerY + radius * sin(angle1) * 10;
        final x2 = centerX + radius * cos(angle2) * 10;
        final y2 = centerY + radius * sin(angle2) * 10;
        // Используем флаг для определения цвета ребер
        final edgePaint = Paint()
          ..color = isEdgeBlack
              ? Colors.black
              : AppColors.green // Цвет ребер зависит от флага
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0; // Увеличиваем толщину ребер

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), edgePaint);
      }
    }
    // Рисуем вершины
    for (int i = 0; i < graph.length; i++) {
      final angle = angles[i];
      final x = centerX + radius * cos(angle) * 10;
      final y = centerY + radius * sin(angle) * 10;
      canvas.drawCircle(Offset(x, y), radius, paint);

      // Рисуем текст над вершинами
      final text = graph.keys.elementAt(i).toString();
      final textSpan =
          TextSpan(text: text, style: getTheme().textTheme.bodyLarge);
      final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainter.layout(maxWidth: radius * 2);
      textPainter.paint(canvas, Offset(x, y - radius / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
