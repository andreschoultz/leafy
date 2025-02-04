import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static final _random = Random();

  static List<Color> baseColors = const [
    // Base
    Color.fromRGBO(194, 214, 189, 1),
    Color.fromRGBO(201, 227, 227, 1),
    Color.fromRGBO(242, 218, 198, 1),
    Color.fromRGBO(210, 216, 227, 1),
    Color.fromRGBO(240, 226, 226, 1),

    // Base + Warm Tones
    Color.fromRGBO(205, 199, 188, 1),
    Color.fromRGBO(216, 213, 213, 1),
    Color.fromRGBO(242, 207, 199, 1),
    Color.fromRGBO(220, 213, 218, 1),
    Color.fromRGBO(240, 225, 225, 1),

    // Base + Cold Tones
    Color.fromRGBO(190, 197, 206, 1),
    Color.fromRGBO(202, 210, 227, 1),
    Color.fromRGBO(213, 205, 227, 1),
    Color.fromRGBO(211, 213, 227, 1),
    Color.fromRGBO(230, 225, 235, 1),
  ];

  static final List<Color> randomBaseColors = getRandomColors();

  static List<Color> getRandomColors() {
    List<Color> colors = [];

    for (var x in baseColors) {
      colors.add(HSLColor.fromColor(x).withSaturation(_random.nextDouble() * 0.5).withHue(_random.nextDouble() * 120).toColor());
    }

    return colors;
  }
}