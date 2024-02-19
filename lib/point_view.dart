import 'package:flutter/material.dart';
import 'package:gesture_recognition_v2/point.dart';

class PointView extends CustomPainter {
  final double ringWidth;
  final double ringRadius;
  final bool showUnSelectRing;
  final double circleRadius;
  final Color selectColor;
  final Color unSelectColor;
  final List<Point> points;

  PointView(
      {required this.ringWidth,
      required this.ringRadius,
      required this.showUnSelectRing,
      required this.circleRadius,
      required this.selectColor,
      required this.unSelectColor,
      required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制9个圆
    final ringPaint = Paint()
      ..isAntiAlias = true
      ..color = unSelectColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    final circlePaint = Paint()
      ..isAntiAlias = true
      ..color = unSelectColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final offSet = Offset(point.x, points[i].y);
      final color = point.isSelect ? selectColor : unSelectColor;
      circlePaint.color = color;
      ringPaint.color = color;
      canvas.drawCircle(offSet, circleRadius, circlePaint);
      if (showUnSelectRing || point.isSelect) {
        canvas.drawArc(
          Rect.fromCircle(center: offSet, radius: ringRadius),
          0,
          360,
          false,
          ringPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
