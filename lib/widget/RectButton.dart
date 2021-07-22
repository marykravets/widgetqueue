import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';

import 'BaseCustomButton.dart';

class RectButton extends BaseCustomButton {
  RectButton(this._color);

  final Color? _color;

  @override
  Container getContainer() {
    return Container(
        width: 200.0,
        height: 30.0,
        child: RawMaterialButton(
          shape: ConstMethod.getRoundedBorder(),
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
