import 'package:flutter/material.dart';

// For Color palettes reffer https://www.canva.com/colors/color-palettes/

// Mountain Haze color palette
const Color darkBlue = Color(0xFF071330);
const Color midNightBlue = Color(0xFF071330);
const Color blueGrey = Color(0xFF071330);
const Color mistyBlue = Color(0xFF071330);

// Dark theme
const Color darkGreyColor = Color(0xFF121212);

class AppThemes {
  static final mountainHaze = ThemeData(
    primaryColor: darkBlue,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    // primaryColor: darkGreyColor,
    brightness: Brightness.dark,
  );
}
