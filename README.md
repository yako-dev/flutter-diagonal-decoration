# Diagonal Decoration

You can use plain color or gradient for backgrounds, but there is a third option that can make your app look more interesting.
Use this DiagonalDecoration or MatrixDecoration to create custom backgrounds for your containers.

<p align="center">
  <img src="https://github.com/yako-dev/flutter-diagonal-decoration/blob/main/images/readme_header.png?raw=true" height="600px">
</p>


## Installing:
In your pubspec.yaml
```yaml
dependencies:
  diagonal_decoration: ^1.0.2
```
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
       distanceBetweenLines: 5,
    )
```

<br>


Check out other Yako packages:
[Badges](https://pub.dev/packages/badges),
[Settings UI](https://pub.dev/packages/settings_ui),
[Status Alert](https://pub.dev/packages/status_alert), 
[Full Screen Menu](https://pub.dev/packages/full_screen_menu) and more to come!
