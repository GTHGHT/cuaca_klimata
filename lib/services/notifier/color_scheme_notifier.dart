import 'package:cuaca_klimata/utilities/constants.dart';
import 'package:flutter/material.dart';

class ColorSchemeNotifier extends ChangeNotifier {
  late ColorScheme _colorScheme;
  late ColorScheme _darkColorScheme;

  ColorSchemeNotifier([ColorScheme? colorScheme, ColorScheme? darkColorScheme])
      : _colorScheme = colorScheme ?? kFogCS,
        _darkColorScheme = darkColorScheme ?? kFogDarkCS;

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
