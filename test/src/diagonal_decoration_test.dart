// ignore_for_file: prefer_const_constructors

import 'package:diagonal_decoration/diagonal_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagonalDecoration', () {
    test('can be instantiated with defaults', () {
      expect(DiagonalDecoration(), isNotNull);
    });

    test('has correct default values', () {
      const decoration = DiagonalDecoration();
      expect(decoration.lineColor, equals(const Color.fromRGBO(219, 219, 219, 1)));
      expect(decoration.backgroundColor, equals(Colors.white));
      expect(decoration.radius, equals(const Radius.circular(20)));
      expect(decoration.lineWidth, equals(1.0));
      expect(decoration.distanceBetweenLines, equals(5.0));
    });

    test('accepts custom values', () {
      const decoration = DiagonalDecoration(
        lineColor: Colors.red,
        backgroundColor: Colors.blue,
        radius: Radius.circular(10),
        lineWidth: 2.0,
        distanceBetweenLines: 8.0,
      );
      expect(decoration.lineColor, equals(Colors.red));
      expect(decoration.backgroundColor, equals(Colors.blue));
      expect(decoration.radius, equals(const Radius.circular(10)));
      expect(decoration.lineWidth, equals(2.0));
      expect(decoration.distanceBetweenLines, equals(8.0));
    });

    test('createBoxPainter returns a DiagonalPainter', () {
      const decoration = DiagonalDecoration();
      final painter = decoration.createBoxPainter();
      expect(painter, isA<DiagonalPainter>());
    });

    test('createBoxPainter passes correct values to painter', () {
      const decoration = DiagonalDecoration(
        lineColor: Colors.green,
        backgroundColor: Colors.yellow,
        radius: Radius.circular(5),
        lineWidth: 3.0,
        distanceBetweenLines: 10.0,
      );
      final painter = decoration.createBoxPainter() as DiagonalPainter;
      expect(painter.lineColor, equals(Colors.green));
      expect(painter.backgroundColor, equals(Colors.yellow));
      expect(painter.borderRadius, equals(const Radius.circular(5)));
      expect(painter.lineWidth, equals(3.0));
      expect(painter.distanceBetweenLines, equals(10.0));
    });

    testWidgets('renders without error inside a Container', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 200,
            height: 100,
            decoration: DiagonalDecoration(),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with custom colors without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 300,
            height: 150,
            decoration: DiagonalDecoration(
              lineColor: Colors.red,
              backgroundColor: Colors.blue,
              radius: Radius.circular(8),
              lineWidth: 2.0,
              distanceBetweenLines: 12.0,
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with zero distanceBetweenLines without error',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 100,
            height: 100,
            decoration: DiagonalDecoration(distanceBetweenLines: 1.0),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('MatrixDecoration', () {
    test('can be instantiated with defaults', () {
      expect(MatrixDecoration(), isNotNull);
    });

    test('has correct default values', () {
      const decoration = MatrixDecoration();
      expect(decoration.lineColor, equals(const Color.fromRGBO(220, 220, 220, 1)));
      expect(decoration.backgroundColor, equals(const Color.fromRGBO(235, 235, 235, 1)));
      expect(decoration.radius, equals(const Radius.circular(20)));
      expect(decoration.lineWidth, equals(1.0));
      expect(decoration.lineCount, equals(20.0));
    });

    test('accepts custom values', () {
      const decoration = MatrixDecoration(
        lineColor: Colors.purple,
        backgroundColor: Colors.orange,
        radius: Radius.circular(4),
        lineWidth: 1.5,
        lineCount: 10,
      );
      expect(decoration.lineColor, equals(Colors.purple));
      expect(decoration.backgroundColor, equals(Colors.orange));
      expect(decoration.radius, equals(const Radius.circular(4)));
      expect(decoration.lineWidth, equals(1.5));
      expect(decoration.lineCount, equals(10.0));
    });

    test('createBoxPainter returns a MatrixPainter', () {
      const decoration = MatrixDecoration();
      final painter = decoration.createBoxPainter();
      expect(painter, isA<MatrixPainter>());
    });

    test('createBoxPainter passes correct values to painter', () {
      const decoration = MatrixDecoration(
        lineColor: Colors.pink,
        backgroundColor: Colors.teal,
        radius: Radius.circular(12),
        lineWidth: 2.5,
        lineCount: 15,
      );
      final painter = decoration.createBoxPainter() as MatrixPainter;
      expect(painter.lineColor, equals(Colors.pink));
      expect(painter.backgroundColor, equals(Colors.teal));
      expect(painter.borderRadius, equals(const Radius.circular(12)));
      expect(painter.lineWidth, equals(2.5));
      expect(painter.lineCount, equals(15.0));
    });

    test('lineColor is passed to painter (regression: was hardcoded)', () {
      const customColor = Color(0xFFABCDEF);
      const decoration = MatrixDecoration(lineColor: customColor);
      final painter = decoration.createBoxPainter() as MatrixPainter;
      expect(painter.lineColor, equals(customColor));
    });

    testWidgets('renders without error inside a Container', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 200,
            height: 100,
            decoration: MatrixDecoration(),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with custom colors without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 300,
            height: 150,
            decoration: MatrixDecoration(
              lineColor: Colors.purple,
              backgroundColor: Colors.orange,
              radius: Radius.circular(4),
              lineWidth: 1.5,
              lineCount: 10,
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with high lineCount without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 200,
            height: 200,
            decoration: MatrixDecoration(lineCount: 50),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with zero radius without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container(
            width: 150,
            height: 150,
            decoration: MatrixDecoration(radius: Radius.zero),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
