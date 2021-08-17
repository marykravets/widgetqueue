import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';

import 'BaseCustomButton.dart';

class RectButton extends BaseCustomButton {
  RectButton(this._color);

  final RoundedRectangleBorder _shape = ConstMethod.getRoundedBorder();
  final Color? _color;

  @override
  Container getContainer() {
    return Container(
        width: 200.0,
        height: 30.0,
        child: RawMaterialButton(
          shape: _shape,
          elevation: 0.0,
          fillColor: _color,
          onPressed: () {},
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContainer();
  }
}
