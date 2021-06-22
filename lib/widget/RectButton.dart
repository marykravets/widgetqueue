import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';

class RectButton extends StatelessWidget {
  const RectButton(this._color);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: _color,
        onPressed: () {},
        shape: ConstMethod.getRoundedBorder()
    );
  }
}
