import 'package:flutter/material.dart';
import '../res/Const.dart';
import 'BaseCustomButton.dart';

class CustomButton extends BaseCustomButton {
  CustomButton(this._color);

  final Color? _color;
  static const SizedBox _child = const SizedBox(
    width: 5.0,
    height: 5.0,
  );

  @override
  Container getContainer() {
    return Container(
        width: Const.containerWidth,
        height: Const.containerHeight,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: _color
        ),
        child: _child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContainer();
  }
}
