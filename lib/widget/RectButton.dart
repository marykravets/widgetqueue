import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {

  Color _color;

  RectButton(Color color) {
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: _color,
        onPressed: (){},
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)
            )
        )
    );
  }
}
