import 'package:flutter/material.dart';

class ColorSchemeNotifier extends ChangeNotifier {
  late ColorScheme _colorScheme;
  late ColorScheme _darkColorScheme;

  ColorSchemeNotifier(ColorScheme colorScheme, ColorScheme darkColorScheme)
      : _colorScheme = colorScheme, _darkColorScheme = darkColorScheme;

  ColorScheme get colorScheme => _colorScheme;

  set colorScheme(ColorScheme value) {
    _colorScheme = value;
    notifyListeners();
  }

  ColorScheme get darkColorScheme => _darkColorScheme;

  set darkColorScheme(ColorScheme value) {
    _darkColorScheme = value;
    notifyListeners();
  }
}
