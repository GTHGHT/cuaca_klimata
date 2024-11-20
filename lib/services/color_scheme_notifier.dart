import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSchemeNotifier extends ChangeNotifier{
  late ColorScheme _colorScheme;

  ColorSchemeNotifier(ColorScheme colorScheme): _colorScheme = colorScheme;

  ColorScheme get colorScheme => _colorScheme;

  set colorScheme(ColorScheme newColorScheme) {
    this._colorScheme = newColorScheme;
    notifyListeners();
  }
}