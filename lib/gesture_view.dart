import 'package:flutter/material.dart';
import 'package:gesture_recognition_v2/line_view.dart';
import 'package:gesture_recognition_v2/point_view.dart';
import 'package:gesture_recognition_v2/point.dart';

class GestureView extends StatefulWidget {
  final double size;
  final Color selectColor;
  final Color unSelectColor;
  final double ringWidth;
  final double ringRadius;
  final double circleRadius;
  final double lineWidth;
  final bool showUnSelectRing;
  final bool immediatelyClear;
  final bool forceConsecutiveDots;
  final Function()? onPanDown;
  final Function(List<int>)? onPanUp;

  const GestureView({
    Key? key,
    required this.size,
    this.selectColor = Colors.blue,
    this.unSelectColor = Colors.grey,
    this.ringWidth = 4,
    this.ringRadius = 30,
    this.showUnSelectRing = true,
    this.circleRadius = 20,
    this.lineWidth = 6,
    this.onPanUp,
    this.onPanDown,
    this.immediatelyClear = false,
    this.forceConsecutiveDots = false,
  })  : assert(ringRadius >= circleRadius),
        super(key: key);

  @override
  State<StatefulWidget> createState() => GestureState();
}

class GestureState extends State<GestureView> {
  final List<Point> points = [];
  final List<Point> pathPoints = [];
  double realRadius = 0;
  Point curPoint = Point(position: 0, x: 0, y: 0);

  @override
  void initState() {
    super.initState();
    realRadius = widget.ringRadius + widget.ringWidth / 2;
    final realRingSize = widget.ringRadius + widget.ringWidth / 2;
    final gapWidth = widget.size / 6 - realRingSize;
    for (int i = 0; i < 9; i++) {
      double x = gapWidth + realRingSize;
      double y = gapWidth + realRingSize;
      points.add(Point(x: (1 + i % 3 * 2) * x, y: (1 + i ~/ 3 * 2) * y, position: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          size: Size(widget.size, widget.size),
          painter: PointView(
            ringWidth: widget.ringWidth,
            ringRadius: widget.ringRadius,
            showUnSelectRing: widget.showUnSelectRing,
            circleRadius: widget.circleRadius,
            selectColor: widget.selectColor,
            unSelectColor: widget.unSelectColor,
            points: points,
          ),
        ),
        GestureDetector(
          onPanCancel: _onPanCancel,
          onPanDown: (DragDownDetails e) => _onPanDown(e, context),
          onPanUpdate: (DragUpdateDetails e) => _onPanUpdate(e, context),
          onPanEnd: (DragEndDetails e) => _onPanEnd(e, context),
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: LineView(
              pathPoints: pathPoints,
              selectColor: widget.selectColor,
              lineWidth: widget.lineWidth,
              curPoint: curPoint,
            ),
          ),
        ),
      ],
    );
  }

  _onPanDown(DragDownDetails e, BuildContext context) {
    _clearAllData();
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(e.globalPosition);
    _slideDealt(offset);
    setState(() {
      curPoint = Point(x: offset.dx, y: offset.dy, position: -1);
    });
    if (widget.onPanDown != null) widget.onPanDown!();
  }

  _onPanUpdate(DragUpdateDetails e, BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(e.globalPosition);
    _slideDealt(offset);
    setState(() {
      curPoint = Point(x: offset.dx, y: offset.dy, position: -1);
    });
  }

  _onPanEnd(DragEndDetails e, BuildContext context) {
    if (pathPoints.isNotEmpty) {
      setState(() {
        curPoint = pathPoints[pathPoints.length - 1];
      });
      if (widget.onPanUp != null) {
        List<int> items = pathPoints.map((item) => item.position).toList();
        widget.onPanUp!(items);
      }
      if (widget.immediatelyClear) _clearAllData(); //clear data
    }
  }

  _onPanCancel() {
    _clearAllData(); //clear data
  }

  _slideDealt(Offset offSet) {
    final onPosition = _getPointPosition(offSet.dx, offSet.dy);
    if (onPosition == -1) return;
    final onPoint = points[onPosition];

    if (pathPoints.isNotEmpty && widget.forceConsecutiveDots) {
      final prevPoint = pathPoints.last;
      final offSetDx = ((prevPoint.x + onPoint.x) / 2).abs();
      final offSetDy = ((prevPoint.y + onPoint.y) / 2).abs();
      final midPosition = _getPointPosition(offSetDx, offSetDy);
      if (midPosition != -1) {
        final midPoint = points[midPosition];
        if (!midPoint.isSelect) {
          midPoint.isSelect = true;
          pathPoints.add(midPoint);
        }
      }
    }

    if (!onPoint.isSelect) {
      onPoint.isSelect = true;
      pathPoints.add(onPoint);
    }
  }

  int _getPointPosition(double dx, double dy) {
    int xPosition = -1;
    int yPosition = -1;
    for (int i = 0; i < 3; i++) {
      if (xPosition == -1 && points[i].x + realRadius >= dx && dx >= points[i].x - realRadius) {
        xPosition = i;
      }
      if (yPosition == -1 &&
          points[i * 3].y + realRadius >= dy &&
          dy >= points[i * 3].y - realRadius) {
        yPosition = i;
      }
    }
    if (xPosition == -1 || yPosition == -1) {
      return -1;
    }
    return yPosition * 3 + xPosition;
  }

  _clearAllData() {
    for (int i = 0; i < 9; i++) {
      points[i].isSelect = false;
    }
    pathPoints.clear();
    setState(() {});
  }
}
