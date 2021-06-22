import 'dart:math';
import 'package:flutter/material.dart';

class ConstMethod {

  static List get colors =>
      [Colors.red, Colors.green, Colors.yellow, Colors.blue, Colors.black];

  static final _random = new Random();

  static getRandomColor() => colors[_random.nextInt(colors.length)];

  static MaterialColor getButtonColor(bool isActive) {
    if (isActive) {
      return Colors.blue;
    }
    return Colors.grey;
  }

  static RoundedRectangleBorder getRoundedBorder() {
    return RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(new Radius.circular(20.0)
        )
    );
  }
}
