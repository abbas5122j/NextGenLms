import 'package:flutter/material.dart';

class AdminTheme {
  static const bg = Color(0xFFF4F6FB);
  static const surface = Colors.white;
  static const border = Color(0xFFE5E7EB);
  static const text = Color(0xFF111827);
  static const muted = Color(0xFF64748B);
  static const lightMuted = Color(0xFF94A3B8);
  static const primary = Color(0xFFFF5722);
  static const green = Color(0xFF00C77B);
  static const purple = Color(0xFF7C22FF);
  static const blue = Color(0xFF3B82F6);
  static const red = Color(0xFFFF4D4F);
  static const yellow = Color(0xFFFFB000);
  static const darkBg = Color(0xFF090D16);
  static const darkSurface = Color(0xFF131927);
  static const darkBorder = Color(0xFF273247);
  static const darkText = Colors.white;
  static const darkMuted = Color(0xFF94A3B8);

  static Color background(bool dark) => dark ? darkBg : bg;
  static Color card(bool dark) => dark ? darkSurface : surface;
  static Color foreground(bool dark) => dark ? darkText : text;
  static Color secondary(bool dark) => dark ? darkMuted : muted;
  static Color outline(bool dark) => dark ? darkBorder : border;

  static BoxDecoration cardDecoration(bool dark, {double radius = 22}) {
    return BoxDecoration(
      color: card(dark),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: outline(dark)),
      boxShadow: dark
          ? const []
          : const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
    );
  }
}

class AdminText {
  static TextStyle title(bool dark) => TextStyle(
        color: AdminTheme.foreground(dark),
        fontSize: 32,
        height: 1.05,
        fontWeight: FontWeight.w900,
        letterSpacing: -.9,
      );

  static TextStyle section(bool dark) => TextStyle(
        color: AdminTheme.foreground(dark),
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: -.3,
      );

  static TextStyle body(bool dark) => TextStyle(
        color: AdminTheme.secondary(dark),
        fontSize: 13,
        height: 1.45,
      );

  static TextStyle label(bool dark) => TextStyle(
        color: AdminTheme.secondary(dark),
        fontSize: 11,
        fontWeight: FontWeight.w800,
      );
}
