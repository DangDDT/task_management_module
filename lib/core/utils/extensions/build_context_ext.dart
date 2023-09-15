import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  bool get isLandscapeMode =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}
