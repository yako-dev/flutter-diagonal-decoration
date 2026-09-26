## [2.0.1] - [September 26, 2026]

* README: a **More from Yako** grid with an animated preview of each of our other packages.

## [2.0.0] - [September 25, 2026]
### Breaking Changes
* **Migrated to `package:material_ui`:** Material was decoupled from the Flutter SDK in Flutter 3.47 and now ships as the standalone `material_ui` package. The package now imports `package:material_ui/material_ui.dart` instead of `package:flutter/material.dart` (only for `Colors.white`, the default `DiagonalDecoration.backgroundColor`) and depends on `material_ui: ^1.4.0`. The API is unchanged. Neither decoration reads the Material theme, so they paint the same in apps that use `material_ui` (no `MaterialUiCompatibilityBridge` needed) and in apps still on `package:flutter/material.dart`, which keep working. This is a major version bump, as the Flutter team recommends for this migration
* **Minimum SDK raised** to Dart 3.13.0 / Flutter 3.47.0, the floor required by `material_ui`. Apps on older Flutter keep resolving the previous major, 1.x (1.2.0)

## [1.2.0] - [September 25, 2026]
* **Security:** remove `brose/flutter-diagonal-decoration.zip`, a malicious archive (a Windows executable loader) that was pushed to the repository in October 2025 and shipped in 1.1.0 and 1.1.1, and restore the README text and links that the same change replaced. If you depend on 1.1.0 or 1.1.1, upgrade and do not extract that file from your pub cache
* Fix: two `DiagonalDecoration`s (or `MatrixDecoration`s) with different values compared equal, so rebuilding with a new `lineColor`, `radius`, etc. kept painting the old values and `AnimatedContainer` never switched to the new decoration. `==` and `hashCode` now compare every field
* Add `DiagonalDecoration.lerp` and `MatrixDecoration.lerp`; `AnimatedContainer` now animates between two decorations of the same type
* Fix: `Container(clipBehavior: ...)` clipped the child to a plain rectangle; the clip path now follows `radius`
* Fix: `DiagonalDecoration(distanceBetweenLines: 0)` froze the app in an endless loop. The constructor now asserts `distanceBetweenLines > 0`, and the painter skips the lines when it is not
* Add dartdoc comments to all public members
* Add `analysis_options.yaml` with `flutter_lints` and remove the unnecessary library name
* Remove the unused `mocktail` dev dependency and the stale `coverage_badge.svg`
* Add `.pubignore`, so the README-only header image is no longer published, and update `.gitignore`
* Add pub.dev topics
* README: add pub and CI badges, update the install version and add a `MatrixDecoration` sample
* CI: replace the failing Very Good workflows with a CI workflow (analyze, format check and tests on stable, non-blocking beta job, weekly run), fix automated publishing to pub.dev with OIDC on `v*` tags, and check PR titles for Conventional Commits. Use `actions/checkout@v5`
* Example: regenerate the platform folders for current Flutter (the Android build failed on Gradle 7.5, iOS targeted 11.0) and stop the layout overflowing on narrow phones and in landscape

## [1.1.1] - [Apr 10, 2026]
* Fix README header image URL

## [1.1.0] - [Apr 9, 2026]
* Fix `MatrixDecoration` ignoring `lineColor` parameter (was hardcoded to `Colors.grey.shade300`)
* Fix lint warning: rename `_path` local variable to `path` in `DiagonalPainter`
* Add comprehensive tests for `DiagonalDecoration` and `MatrixDecoration`
* Update dev dependencies: `mocktail` to `^1.0.4`, `flutter_lints` to `^6.0.0`

## [1.0.2+3] - [Jul 9, 2023]
* Update readme

## [1.0.1+2] - [Jul 9, 2023]
* Fix for Dart file convention
## [1.0.0+1] - [Jul 9, 2023]
* First release
