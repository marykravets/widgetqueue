import 'dart:math';
import 'package:flutter/material.dart';

import 'Const.dart';

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

  static SnackBar getDismissBar() {
    return SnackBar(
      content: const Text(Const.strDismissed),
      duration: const Duration(milliseconds: 50),
    );
  }

  static Container getDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red.shade100,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
