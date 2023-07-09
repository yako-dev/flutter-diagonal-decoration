import 'package:flutter/material.dart';

/// Provides a diagonal decoration to a [Container] or a [BoxDecoration].
class DiagonalDecoration extends BoxDecoration {
  const DiagonalDecoration({
    this.lineColor = const Color.fromRGBO(219, 219, 219, 1),
    this.backgroundColor = Colors.white,
    this.radius = const Radius.circular(20),
    this.lineWidth = 1,
    this.distanceBetweenLines = 5,
  });

  // The color of the diagonal lines.
  final Color lineColor;

  // The color of the background.
  final Color backgroundColor;

  // The radius of the container.
  final Radius radius;

  // The width of the diagonal lines.
  final double lineWidth;

  // The distance between the diagonal lines.
  final double distanceBetweenLines;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return DiagonalPainter(
      lineColor,
      backgroundColor,
      radius,
      lineWidth,
      distanceBetweenLines,
    );
  }
}

class DiagonalPainter extends BoxPainter {
  DiagonalPainter(
    this.lineColor,
    this.backgroundColor,
    this.borderRadius,
    this.lineWidth,
    this.distanceBetweenLines,
  );
  final Color lineColor;
  final Color backgroundColor;
  final Radius borderRadius;
  final double lineWidth;
  final double distanceBetweenLines;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(rect, borderRadius);
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);

    Path _path = Path();
    Offset position = rect.center;
    double widthf = rect.width / 2.0;
    double heightf = rect.height / 2.0;
    _path.moveTo(position.dx, position.dy);
    for (int i = 0; i < widthf / distanceBetweenLines * 2; i++) {
      _path.relativeMoveTo(-distanceBetweenLines * i, 0);
      _path.relativeMoveTo(widthf, -heightf);
      _path.relativeLineTo(-widthf * 2, heightf * 2);
      _path.moveTo(position.dx, position.dy);

      _path.relativeMoveTo(distanceBetweenLines * i, 0);
      _path.relativeMoveTo(widthf, -heightf);
      _path.relativeLineTo(-widthf * 2, heightf * 2);
      _path.moveTo(position.dx, position.dy);
    }
    canvas.save();
    canvas.clipRRect(rrect);

    canvas.drawPath(
        _path..fillType = PathFillType.evenOdd,
        Paint()
          ..color = lineColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidth);
    canvas.restore();
  }
}
