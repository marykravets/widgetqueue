import 'package:flutter/material.dart';
import '../res/Const.dart';
import 'DraggingListItem.dart';

final GlobalKey _draggableKey = GlobalKey();

class CustomButton extends StatelessWidget {
  const CustomButton(this._color);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<FloatingActionButton>(
        dragAnchor: DragAnchor.pointer,
        feedback: DraggingListItem(
            dragKey: _draggableKey,
            color: _color,
            isRect: false,
        ),
        child: Container(
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
        )
    );
  }
}
