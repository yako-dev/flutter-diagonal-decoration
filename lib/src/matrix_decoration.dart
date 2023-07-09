import 'package:flutter/material.dart';

/// Provides a matrix decoration to a [Container] or a [BoxDecoration].
class MatrixDecoration extends BoxDecoration {
  const MatrixDecoration({
    this.lineColor = const Color.fromRGBO(220, 220, 220, 1),
    this.backgroundColor = const Color.fromRGBO(235, 235, 235, 1),
    this.radius = const Radius.circular(20),
    this.lineWidth = 1,
    this.lineCount = 20,
  });

  // The color of the diagonal lines.
  final Color lineColor;

  // The color of the background.
  final Color backgroundColor;

  // The radius of the container.
  final Radius radius;

  // The width of the diagonal lines.
  final double lineWidth;

  // The number of lines.
  final double lineCount;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return MatrixPainter(
      lineColor,
      backgroundColor,
      radius,
      lineWidth,
      lineCount,
    );
  }
}

class MatrixPainter extends BoxPainter {
  MatrixPainter(
    this.lineColor,
    this.backgroundColor,
    this.borderRadius,
    this.lineWidth,
    this.lineCount,
  );
  final Color lineColor;
  final Color backgroundColor;
  final Radius borderRadius;
  final double lineWidth;
  final double lineCount;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(rect, borderRadius);
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);

    final lineHeight = rect.height / lineCount;

    final diagonalPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = lineWidth;

    canvas.save();
    canvas.clipRRect(rrect);

    for (var i = 0; i < lineCount; i++) {
      final startX = rect.left;
      final startY = rect.top + i * lineHeight;

      final endX = rect.left + (i + 1) * rect.width / lineCount;
      final endY = rect.bottom;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        diagonalPaint,
      );
    }

    canvas.restore();
  }
}
