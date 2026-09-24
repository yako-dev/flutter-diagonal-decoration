import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Provides a matrix decoration to a [Container] or a [BoxDecoration].
class MatrixDecoration extends BoxDecoration {
  /// Creates a decoration with a fan of lines over a rounded background.
  const MatrixDecoration({
    this.lineColor = const Color.fromRGBO(220, 220, 220, 1),
    this.backgroundColor = const Color.fromRGBO(235, 235, 235, 1),
    this.radius = const Radius.circular(20),
    this.lineWidth = 1,
    this.lineCount = 20,
  });

  /// The color of the lines.
  final Color lineColor;

  /// The color of the background.
  final Color backgroundColor;

  /// The radius of the container.
  final Radius radius;

  /// The width of the lines.
  final double lineWidth;

  /// The number of lines.
  final double lineCount;

  /// Linearly interpolates between two [MatrixDecoration]s.
  ///
  /// If one end is null, the colors of the other end fade in from (or out
  /// to) transparent, like [BoxDecoration.lerp] does.
  static MatrixDecoration? lerp(
    MatrixDecoration? a,
    MatrixDecoration? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return b!._withColorScale(t);
    }
    if (b == null) {
      return a._withColorScale(1.0 - t);
    }
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    return MatrixDecoration(
      lineColor: Color.lerp(a.lineColor, b.lineColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      radius: Radius.lerp(a.radius, b.radius, t)!,
      // Curves that overshoot (t < 0 or t > 1) must not produce negative
      // values.
      lineWidth: math.max(0.0, lerpDouble(a.lineWidth, b.lineWidth, t)!),
      lineCount: math.max(0.0, lerpDouble(a.lineCount, b.lineCount, t)!),
    );
  }

  MatrixDecoration _withColorScale(double factor) {
    return MatrixDecoration(
      lineColor: Color.lerp(null, lineColor, factor)!,
      backgroundColor: Color.lerp(null, backgroundColor, factor)!,
      radius: radius,
      lineWidth: lineWidth,
      lineCount: lineCount,
    );
  }

  @override
  BoxDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null || a is MatrixDecoration) {
      return MatrixDecoration.lerp(a as MatrixDecoration?, this, t);
    }
    return super.lerpFrom(a, t);
  }

  @override
  BoxDecoration? lerpTo(Decoration? b, double t) {
    if (b == null || b is MatrixDecoration) {
      return MatrixDecoration.lerp(this, b as MatrixDecoration?, t);
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRRect(RRect.fromRectAndRadius(rect, radius));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MatrixDecoration &&
        other.lineColor == lineColor &&
        other.backgroundColor == backgroundColor &&
        other.radius == radius &&
        other.lineWidth == lineWidth &&
        other.lineCount == lineCount;
  }

  @override
  int get hashCode => Object.hash(
        lineColor,
        backgroundColor,
        radius,
        lineWidth,
        lineCount,
      );

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

/// The [BoxPainter] that paints a [MatrixDecoration].
class MatrixPainter extends BoxPainter {
  /// Creates a painter for a [MatrixDecoration].
  MatrixPainter(
    this.lineColor,
    this.backgroundColor,
    this.borderRadius,
    this.lineWidth,
    this.lineCount,
  );

  /// The color of the lines.
  final Color lineColor;

  /// The color of the background.
  final Color backgroundColor;

  /// The radius of the painted area.
  final Radius borderRadius;

  /// The width of the lines.
  final double lineWidth;

  /// The number of lines.
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
      ..color = lineColor
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
