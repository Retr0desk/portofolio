import 'package:flutter/material.dart';

/// Token radius sudut yang konsisten dan terukur.
abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;

  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius control = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius media = BorderRadius.all(Radius.circular(md));
}
