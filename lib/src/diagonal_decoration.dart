import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Provides a diagonal decoration to a [Container] or a [BoxDecoration].
class DiagonalDecoration extends BoxDecoration {
  /// Creates a decoration with diagonal lines over a rounded background.
  ///
  /// [distanceBetweenLines] must be greater than zero.
  const DiagonalDecoration({
    this.lineColor = const Color.fromRGBO(219, 219, 219, 1),
    this.backgroundColor = Colors.white,
    this.radius = const Radius.circular(20),
    this.lineWidth = 1,
    this.distanceBetweenLines = 5,
  }) : assert(
          distanceBetweenLines > 0,
          'distanceBetweenLines must be greater than zero',
        );

  /// The color of the diagonal lines.
  final Color lineColor;

  /// The color of the background.
  final Color backgroundColor;

  /// The radius of the container.
  final Radius radius;

  /// The width of the diagonal lines.
  final double lineWidth;

  /// The distance between the diagonal lines.
  final double distanceBetweenLines;

  /// Linearly interpolates between two [DiagonalDecoration]s.
  ///
  /// If one end is null, the colors of the other end fade in from (or out
  /// to) transparent, like [BoxDecoration.lerp] does.
  static DiagonalDecoration? lerp(
    DiagonalDecoration? a,
    DiagonalDecoration? b,
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
    return DiagonalDecoration(
      lineColor: Color.lerp(a.lineColor, b.lineColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      radius: Radius.lerp(a.radius, b.radius, t)!,
      // Curves that overshoot (t < 0 or t > 1) must not produce a negative
      // width or a spacing of zero or less.
      lineWidth: math.max(0.0, lerpDouble(a.lineWidth, b.lineWidth, t)!),
      distanceBetweenLines: math.max(
        math.min(a.distanceBetweenLines, b.distanceBetweenLines),
        lerpDouble(a.distanceBetweenLines, b.distanceBetweenLines, t)!,
      ),
    );
  }

  DiagonalDecoration _withColorScale(double factor) {
    return DiagonalDecoration(
      lineColor: Color.lerp(null, lineColor, factor)!,
      backgroundColor: Color.lerp(null, backgroundColor, factor)!,
      radius: radius,
      lineWidth: lineWidth,
      distanceBetweenLines: distanceBetweenLines,
    );
  }

  @override
  BoxDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null || a is DiagonalDecoration) {
      return DiagonalDecoration.lerp(a as DiagonalDecoration?, this, t);
    }
    return super.lerpFrom(a, t);
  }

  @override
  BoxDecoration? lerpTo(Decoration? b, double t) {
    if (b == null || b is DiagonalDecoration) {
      return DiagonalDecoration.lerp(this, b as DiagonalDecoration?, t);
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
    return other is DiagonalDecoration &&
        other.lineColor == lineColor &&
        other.backgroundColor == backgroundColor &&
        other.radius == radius &&
        other.lineWidth == lineWidth &&
        other.distanceBetweenLines == distanceBetweenLines;
  }

  @override
  int get hashCode => Object.hash(
        lineColor,
        backgroundColor,
        radius,
        lineWidth,
        distanceBetweenLines,
      );

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

/// The [BoxPainter] that paints a [DiagonalDecoration].
class DiagonalPainter extends BoxPainter {
  /// Creates a painter for a [DiagonalDecoration].
  DiagonalPainter(
    this.lineColor,
    this.backgroundColor,
    this.borderRadius,
    this.lineWidth,
    this.distanceBetweenLines,
  );

  /// The color of the diagonal lines.
  final Color lineColor;

  /// The color of the background.
  final Color backgroundColor;

  /// The radius of the painted area.
  final Radius borderRadius;

  /// The width of the diagonal lines.
  final double lineWidth;

  /// The distance between the diagonal lines.
  final double distanceBetweenLines;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final rrect = RRect.fromRectAndRadius(rect, borderRadius);
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);

    // A spacing of zero or less (or NaN) would never end the loop below.
    if (!(distanceBetweenLines > 0)) {
      return;
    }

    Path path = Path();
    Offset position = rect.center;
    double widthf = rect.width / 2.0;
    double heightf = rect.height / 2.0;
    path.moveTo(position.dx, position.dy);
    for (int i = 0; i < widthf / distanceBetweenLines * 2; i++) {
      path.relativeMoveTo(-distanceBetweenLines * i, 0);
      path.relativeMoveTo(widthf, -heightf);
      path.relativeLineTo(-widthf * 2, heightf * 2);
      path.moveTo(position.dx, position.dy);

      path.relativeMoveTo(distanceBetweenLines * i, 0);
      path.relativeMoveTo(widthf, -heightf);
      path.relativeLineTo(-widthf * 2, heightf * 2);
      path.moveTo(position.dx, position.dy);
    }
    canvas.save();
    canvas.clipRRect(rrect);

    canvas.drawPath(
        path..fillType = PathFillType.evenOdd,
        Paint()
          ..color = lineColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidth);
    canvas.restore();
  }
}
