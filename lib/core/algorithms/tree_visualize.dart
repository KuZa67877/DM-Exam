// import 'dart:math';

// import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';
// import 'package:dmiti_project/res/colors.dart';
// import 'package:flutter/material.dart';

// class TreeWidget extends StatelessWidget {
//   final Node root;

//   TreeWidget({required this.root});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TreePainter(root),
//       child: Container(),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final Node root;

//   TreePainter(this.root);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.green
//       ..style = PaintingStyle.fill;

//     final textPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     _drawNode(
//         canvas, root, size.width / 2, 20, size.width / 4, paint, textPaint);
//   }

//   void _drawNode(Canvas canvas, Node node, double x, double y, double width,
//       Paint paint, Paint textPaint) {
//     canvas.drawCircle(Offset(x, y), 20, paint);
//     final textSpan = TextSpan(
//         text: node.name.toString(), style: TextStyle(color: Colors.white));
//     final textPainter = TextPainter(
//         text: textSpan,
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center);
//     textPainter.layout();
//     textPainter.paint(
//         canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));

//     double childX = x - width / 2;
//     double step = width / (node.childs.length + 1);
//     for (var child in node.childs) {
//       if (child != null) {
//         canvas.drawLine(
//             Offset(x, y + 20), Offset(childX + step, y + 80 - 20), paint);
//         _drawNode(
//             canvas, child, childX + step, y + 80, width / 2, paint, textPaint);
//         childX += step;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
