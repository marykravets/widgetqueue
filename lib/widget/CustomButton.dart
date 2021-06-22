import 'package:flutter/material.dart';
import '../res/Const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this._color);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
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
}
