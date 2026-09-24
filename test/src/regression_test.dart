import 'dart:ui' as ui;

import 'package:diagonal_decoration/diagonal_decoration.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _rect = Rect.fromLTWH(0, 0, 100, 100);

Widget _boxWith(Decoration decoration, {bool animated = false}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: animated
          ? AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 100,
              height: 100,
              decoration: decoration,
            )
          : Container(width: 100, height: 100, decoration: decoration),
    ),
  );
}

RenderDecoratedBox _decoratedBox(WidgetTester tester) {
  return tester.renderObject<RenderDecoratedBox>(find.byType(DecoratedBox));
}

void main() {
  group('DiagonalDecoration regressions', () {
    test('decorations with different values are not equal', () {
      const base = DiagonalDecoration();
      const variants = [
        DiagonalDecoration(lineColor: Colors.red),
        DiagonalDecoration(backgroundColor: Colors.blue),
        DiagonalDecoration(radius: Radius.circular(4)),
        DiagonalDecoration(lineWidth: 3),
        DiagonalDecoration(distanceBetweenLines: 9),
      ];
      for (final variant in variants) {
        expect(variant, isNot(equals(base)));
      }
      // ignore: prefer_const_constructors
      final same = DiagonalDecoration();
      expect(same, equals(base));
      expect(same.hashCode, equals(base.hashCode));
    });

    testWidgets('rebuilding with a new lineColor repaints with it', (
      tester,
    ) async {
      await tester.pumpWidget(
        _boxWith(const DiagonalDecoration(lineColor: Colors.red)),
      );
      await tester.pumpWidget(
        _boxWith(const DiagonalDecoration(lineColor: Colors.blue)),
      );
      expect(
        _decoratedBox(tester),
        paints
          ..rrect(color: Colors.white)
          ..path(color: Colors.blue),
      );
    });

    testWidgets('AnimatedContainer animates between two decorations', (
      tester,
    ) async {
      await tester.pumpWidget(
        _boxWith(
          const DiagonalDecoration(lineColor: Colors.red),
          animated: true,
        ),
      );
      await tester.pumpWidget(
        _boxWith(
          const DiagonalDecoration(lineColor: Colors.blue),
          animated: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      final mid = _decoratedBox(tester).decoration;
      expect(mid, isA<DiagonalDecoration>());
      expect(
        (mid as DiagonalDecoration).lineColor,
        equals(Color.lerp(Colors.red, Colors.blue, 0.5)),
      );
      await tester.pumpAndSettle();
      expect(
        (_decoratedBox(tester).decoration as DiagonalDecoration).lineColor,
        equals(Colors.blue),
      );
    });

    test('lerp interpolates every field and clamps overshoot', () {
      const a = DiagonalDecoration(
        lineColor: Color(0xFF000000),
        backgroundColor: Color(0xFF000000),
        radius: Radius.circular(0),
        lineWidth: 1,
        distanceBetweenLines: 2,
      );
      const b = DiagonalDecoration(
        lineColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFFFFFFF),
        radius: Radius.circular(10),
        lineWidth: 3,
        distanceBetweenLines: 10,
      );
      final mid = DiagonalDecoration.lerp(a, b, 0.5)!;
      expect(mid.lineColor, Color.lerp(a.lineColor, b.lineColor, 0.5));
      expect(
        mid.backgroundColor,
        Color.lerp(a.backgroundColor, b.backgroundColor, 0.5),
      );
      expect(mid.radius, const Radius.circular(5));
      expect(mid.lineWidth, 2);
      expect(mid.distanceBetweenLines, 6);

      final overshoot = DiagonalDecoration.lerp(a, b, -1)!;
      expect(overshoot.lineWidth, 0);
      expect(overshoot.distanceBetweenLines, 2);

      final fadeIn = Decoration.lerp(null, b, 0.5)! as DiagonalDecoration;
      expect(fadeIn.lineColor, Color.lerp(null, b.lineColor, 0.5));
      expect(fadeIn.distanceBetweenLines, b.distanceBetweenLines);
    });

    test('getClipPath follows the radius', () {
      const decoration = DiagonalDecoration(radius: Radius.circular(20));
      final path = decoration.getClipPath(_rect, TextDirection.ltr);
      expect(path.contains(const Offset(1, 1)), isFalse);
      expect(path.contains(const Offset(50, 50)), isTrue);
    });

    test('asserts that distanceBetweenLines is greater than zero', () {
      double zero() => 0;
      expect(
        () => DiagonalDecoration(distanceBetweenLines: zero()),
        throwsAssertionError,
      );
    });

    test(
      'painter draws no lines when distanceBetweenLines is not positive',
      () {
        // The old painter looped forever here (this test hangs on it).
        final recorder = ui.PictureRecorder();
        DiagonalPainter(Colors.black, Colors.white, Radius.zero, 1, 0).paint(
          Canvas(recorder),
          Offset.zero,
          const ImageConfiguration(size: Size(100, 100)),
        );
        recorder.endRecording().dispose();
      },
    );
  });

  group('MatrixDecoration regressions', () {
    test('decorations with different values are not equal', () {
      const base = MatrixDecoration();
      const variants = [
        MatrixDecoration(lineColor: Colors.red),
        MatrixDecoration(backgroundColor: Colors.blue),
        MatrixDecoration(radius: Radius.circular(4)),
        MatrixDecoration(lineWidth: 3),
        MatrixDecoration(lineCount: 9),
      ];
      for (final variant in variants) {
        expect(variant, isNot(equals(base)));
      }
      // ignore: prefer_const_constructors
      final same = MatrixDecoration();
      expect(same, equals(base));
      expect(same.hashCode, equals(base.hashCode));
    });

    testWidgets('rebuilding with a new lineColor repaints with it', (
      tester,
    ) async {
      await tester.pumpWidget(
        _boxWith(const MatrixDecoration(lineColor: Colors.red, lineCount: 1)),
      );
      await tester.pumpWidget(
        _boxWith(const MatrixDecoration(lineColor: Colors.blue, lineCount: 1)),
      );
      expect(
        _decoratedBox(tester),
        paints
          ..rrect()
          ..line(color: Colors.blue),
      );
    });

    testWidgets('AnimatedContainer animates between two decorations', (
      tester,
    ) async {
      await tester.pumpWidget(
        _boxWith(const MatrixDecoration(lineColor: Colors.red), animated: true),
      );
      await tester.pumpWidget(
        _boxWith(
          const MatrixDecoration(lineColor: Colors.blue),
          animated: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      final mid = _decoratedBox(tester).decoration;
      expect(mid, isA<MatrixDecoration>());
      expect(
        (mid as MatrixDecoration).lineColor,
        equals(Color.lerp(Colors.red, Colors.blue, 0.5)),
      );
    });

    test('lerp interpolates every field', () {
      const a = MatrixDecoration(
        radius: Radius.circular(0),
        lineWidth: 1,
        lineCount: 10,
      );
      const b = MatrixDecoration(
        radius: Radius.circular(10),
        lineWidth: 3,
        lineCount: 20,
      );
      final mid = MatrixDecoration.lerp(a, b, 0.5)!;
      expect(mid.radius, const Radius.circular(5));
      expect(mid.lineWidth, 2);
      expect(mid.lineCount, 15);
    });

    test('getClipPath follows the radius', () {
      const decoration = MatrixDecoration(radius: Radius.circular(20));
      final path = decoration.getClipPath(_rect, TextDirection.ltr);
      expect(path.contains(const Offset(1, 1)), isFalse);
      expect(path.contains(const Offset(50, 50)), isTrue);
    });
  });
}
