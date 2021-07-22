import 'package:flutter/material.dart';
import '../res/Const.dart';
import 'BaseCustomButton.dart';

class CustomButton extends BaseCustomButton {
  CustomButton(this._color);

  final Color? _color;

  @override
  Container getContainer() {
    return Container(
        width: Const.containerWidth,
        height: Const.containerHeight,
        child: FloatingActionButton(
          backgroundColor: _color,
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              SizedBox(
                width: 5.0,
                height: 5.0,
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return getContainer();
  }
}
