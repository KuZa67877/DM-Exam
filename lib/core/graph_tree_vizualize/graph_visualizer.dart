import 'dart:math';
import 'dart:ui';
import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final Map<int, Set<int>> graph;

  GraphWidget({required this.graph});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GraphPainter(graph, context, isEdgeBlack: false),
      child: Container(),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, Set<int>> graph;
  final BuildContext context;
  late bool isEdgeBlack;

  GraphPainter(this.graph, this.context, {this.isEdgeBlack = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.fill;

    // final textPaint = Paint()
    //   ..color = Colors.white
    //   ..style = PaintingStyle.fill;

    final radius = 15.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final int numVertices = graph.keys.length;
    final angleStep = 2 * pi / numVertices;
    final angles =
        List<double>.generate(numVertices, (index) => index * angleStep);

    isEdgeBlack = false;
    for (final vertex in graph.keys) {
      final edges = graph[vertex] ?? {};
      for (final edge in edges) {
        final angle1 = angles[vertex - 1];
        final angle2 = angles[edge - 1];
        final x1 = centerX + radius * cos(angle1) * 10;
        final y1 = centerY + radius * sin(angle1) * 10;
        final x2 = centerX + radius * cos(angle2) * 10;
        final y2 = centerY + radius * sin(angle2) * 10;

        canvas.drawLine(
            Offset(x1, y1),
            Offset(x2, y2),
            Paint()
              ..color = AppColors.black
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2.0);
        if (isEdgeBlack) {
          final dx = x2 - x1;
          final dy = y2 - y1;
          final direction = atan2(dy, dx); // Угол направления от x1 до x2

          // Вычисление тангенса угла наклона и пересечения с осью Y
          final m = dy / dx;
          final c = y1 - m * x1;

          // Определение, является ли прямая вертикальной или горизонтальной
          final isVertical =
              m.abs() > 100; // Можно настроить пороговое значение
          final isHorizontal =
              m.abs() < 0.01; // Можно настроить пороговое значение

          // Коррекция положения стрелки в зависимости от типа прямой
          final correctionFactor =
              isVertical ? -90 : -20; // Настройте этот параметр
          final adjustedX2 = x2 +
              correctionFactor *
                  cos(direction); //TODO на будущее: коэфициент подбирать в зависимости от того, вертикальная или горизонтальная вершина, условно тут нормальный кэф в случае, если ребро вертикальное и направленно сверху вниз, для горизонтальных скорее всего ставить положительные значения коэфициента
          final adjustedY2 = y2 + correctionFactor * sin(direction);

          // Выбор точки для начала стрелки, которая лежит на прямой
          final arrowStartX = adjustedX2;
          final arrowStartY = m * arrowStartX + c;

          final arrowSize = 15.0;
          final arrowXLeft = arrowStartX - arrowSize * cos(direction - pi / 6);
          final arrowYLeft = arrowStartY - arrowSize * sin(direction - pi / 6);
          canvas.drawLine(
              Offset(arrowStartX, arrowStartY),
              Offset(arrowXLeft, arrowYLeft),
              Paint()
                ..color = AppColors.black
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2.0);

          final arrowXRight = arrowStartX - arrowSize * cos(direction + pi / 6);
          final arrowYRight = arrowStartY - arrowSize * sin(direction + pi / 6);
          canvas.drawLine(
              Offset(arrowStartX, arrowStartY),
              Offset(arrowXRight, arrowYRight),
              Paint()
                ..color = AppColors.black
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2.0);
        }
      }
    }
    for (int i = 0; i < numVertices; i++) {
      final angle = angles[i];
      final x = centerX + radius * cos(angle) * 10;
      final y = centerY + radius * sin(angle) * 10;
      canvas.drawCircle(Offset(x, y), 10, paint);
      final text = graph.keys.elementAt(i).toString();
      final textSpan =
          TextSpan(text: text, style: TextStyle(color: Colors.white));
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
