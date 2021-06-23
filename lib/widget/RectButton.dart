import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';

class RectButton extends StatelessWidget {
  const RectButton(this._color);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        height: 30.0,
        child: new RawMaterialButton(
          shape: ConstMethod.getRoundedBorder(),
          elevation: 0.0,
          fillColor: _color,
          onPressed: () {},
        )
    );
  }
}
