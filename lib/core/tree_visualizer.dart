// import 'dart:ui';
// import 'package:dmiti_project/core/algorithms/graph_tree/Node.dart';
// import 'package:flutter/material.dart';

// class TreePainter extends CustomPainter {
//   final Node? root;
//   final double nodeRadius = 20.0;
//   final double levelSpacing = 30.0;

//   TreePainter(this.root);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.green
//       ..style = PaintingStyle.fill;

//     final textPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;

//     drawNodes(canvas, size, 0, 0);
//   }

//   void drawNodes(Canvas canvas, Size size, int x, int y) {
//     if (root == null || root!.childs.isEmpty) return;

//     final newX = x + levelSpacing;
//     final newY = y + nodeRadius * 2; // Увеличиваем смещение для каждого уровня
//     canvas.drawCircle(Offset(newX, newY), nodeRadius, paint as Paint);
//     final text = root!.name.toString();
//     final textSpan = TextSpan(text: text, style: TextStyle(fontSize: 14));
//     final textPainter =
//         TextPainter(text: textSpan, textDirection: TextDirection.ltr);
//     textPainter.layout(maxWidth: nodeRadius * 2);
//     textPainter.paint(canvas, Offset(newX, newY - nodeRadius));

//     if (root!.childs.isNotEmpty) {
//       drawNodes(
//           canvas,
//           size,
//           newX as int,
//           (newY + nodeRadius * 2)
//               as int); // Рекурсивный вызов для дочерних узлов
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// // class TreeWidget extends StatelessWidget {
// //   final Node root;

// //   TreeWidget({required this.root});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Дерево"),
// //       ),
// //       body: Center(
// //         child: CustomPaint(
// //           painter: TreePainter(root),
// //           child: Container(),
// //         ),
// //       ),
// //     );
// //   }
// // }
