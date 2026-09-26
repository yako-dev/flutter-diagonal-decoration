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


<!-- more-from-yako:start -->
## More from Yako

Other Flutter packages from the same team:

<table>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/settings_ui"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/settings_ui.gif" width="220" alt="Animated demo of the settings_ui Flutter package: an iOS-style settings screen with Appearance and General sections; turning on Dark mode switches the whole list to dark."></a><br>
      <a href="https://pub.dev/packages/settings_ui"><b>settings_ui</b></a><br>
      <sub>Settings screens that look native on every platform.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/badges"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/badges.gif" width="220" alt="Animated demo of the badges Flutter package: a count badge on a cart icon goes from 1 to 4, a notification badge pops in, and a Twitter-style verified badge, a NEW label and an Instagram-shaped badge appear."></a><br>
      <a href="https://pub.dev/packages/badges"><b>badges</b></a><br>
      <sub>Badges for any widget: counters, dots, shapes and animations.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/yako_celebrations"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/yako_celebrations.webp" width="220" alt="Animated demo of the yako_celebrations Flutter package: an epic celebration fills a dark screen with fireworks, flames, spinning coins, confetti and popping Yako logos under a LEVEL UP! title."></a><br>
      <a href="https://pub.dev/packages/yako_celebrations"><b>yako_celebrations</b></a><br>
      <sub>Full-screen celebrations in one line: confetti, coins, fireworks, flames.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/status_alert"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/status_alert.gif" width="220" alt="Animated demo of the status_alert Flutter package: liking a song shows an Apple-style blurred Loved popup with an icon and a subtitle, which then fades away."></a><br>
      <a href="https://pub.dev/packages/status_alert"><b>status_alert</b></a><br>
      <sub>Apple-style status alerts that hide themselves.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/full_screen_menu"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/full_screen_menu.gif" width="220" alt="Animated demo of the full_screen_menu Flutter package: a blurred full-screen overlay opens over a weather app with five round gradient buttons and a close button."></a><br>
      <a href="https://pub.dev/packages/full_screen_menu"><b>full_screen_menu</b></a><br>
      <sub>A full-screen menu with round gradient buttons.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/yako_theme_switch"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/yako_theme_switch.gif" width="220" alt="Animated demo of the yako_theme_switch Flutter package: a toggle whose sun thumb rolls into a moon as the screen changes from light mode to dark mode."></a><br>
      <a href="https://pub.dev/packages/yako_theme_switch"><b>yako_theme_switch</b></a><br>
      <sub>An animated switch between light and dark themes.</sub>
    </td>
  </tr>
</table>
<!-- more-from-yako:end -->
