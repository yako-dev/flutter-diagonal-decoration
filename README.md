# Diagonal Decoration

[![pub package](https://img.shields.io/pub/v/diagonal_decoration.svg)](https://pub.dev/packages/diagonal_decoration)
[![CI](https://github.com/yako-dev/flutter-diagonal-decoration/actions/workflows/ci.yml/badge.svg)](https://github.com/yako-dev/flutter-diagonal-decoration/actions/workflows/ci.yml)

You can use plain color or gradient for backgrounds, but there is a third option that can make your app look more interesting.
Use this DiagonalDecoration or MatrixDecoration to create custom backgrounds for your containers.

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-diagonal-decoration/main/images/readme_header.png" height="600px">
</p>


## Installing:
Requirements: Flutter 3.47+ (`material_ui`). On older Flutter, use `diagonal_decoration: ^1.2.0`.

In your pubspec.yaml
```yaml
dependencies:
  diagonal_decoration: ^2.0.0
```
The samples below use `Colors` from `package:material_ui/material_ui.dart`. Apps that haven't migrated to `material_ui` yet can keep `package:flutter/material.dart`.
<br>

## Basic Usage:
Just add DiagonalDecoration or MatrixDecoration to your Container's decoration parameter
```dart
    return Container(
      width: 200,
      height: 200,
      decoration: DiagonalDecoration(),
    );
```
## Advanced usage
```dart
    decoration: const DiagonalDecoration(
       lineColor: Colors.black,
       backgroundColor: Colors.grey,
       radius: Radius.circular(20),
       lineWidth: 1,
       distanceBetweenLines: 5, // must be greater than 0
    )
```
```dart
    decoration: const MatrixDecoration(
       lineColor: Colors.black12,
       backgroundColor: Colors.white,
       radius: Radius.circular(12),
       lineWidth: 1,
       lineCount: 20,
    )
```

Both decorations work with `AnimatedContainer`, which animates between two
decorations of the same type, and with `Container(clipBehavior: ...)`, which
clips the child to the rounded corners.

<br>


Check out other Yako packages:
[Badges](https://pub.dev/packages/badges),
[Settings UI](https://pub.dev/packages/settings_ui),
[Status Alert](https://pub.dev/packages/status_alert), 
[Full Screen Menu](https://pub.dev/packages/full_screen_menu) and more to come!
