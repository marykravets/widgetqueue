import 'package:flutter/material.dart';

import 'Const.dart';

class CustomButton extends StatelessWidget {

  Color _color;

  CustomButton(color) {
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Const.containerWidth,
        height: Const.containerHeight,
        child: FloatingActionButton(
          backgroundColor: _color,
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
}