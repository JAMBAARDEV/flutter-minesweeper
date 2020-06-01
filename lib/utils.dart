import 'package:flutter/material.dart';

class CellBoxDecoration {
  static const BoxDecoration blackBox = BoxDecoration(color: Colors.black);
  static const BoxDecoration gradientBox = BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.yellow, Colors.black12],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft),
  );
  static const orangeBox = BoxDecoration(color: Colors.deepOrange);
}
