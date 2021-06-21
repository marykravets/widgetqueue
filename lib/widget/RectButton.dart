import 'package:flutter/material.dart';
import 'DraggingListItem.dart';

final GlobalKey _draggableKey = GlobalKey();

class RectButton extends StatelessWidget {
  const RectButton(this._color);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<FloatingActionButton>(
      dragAnchor: DragAnchor.pointer,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        color: _color,
        isRect: true,
      ),
      child: FloatingActionButton(
          backgroundColor: _color,
          onPressed: () {},
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)
              )
          )
      ),
    );
  }
}
