import 'package:flutter/material.dart';
import 'package:widgetqueue/res/Const.dart';

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    Key? key,
    required this.color,
    required this.dragKey,
    required this.isRect
  }) : super(key: key);

  final GlobalKey dragKey;
  final Color? color;
  final bool isRect;

  static const RoundedRectangleBorder _listItemShape = RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)
      )
  );

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(5.0),
        child: SizedBox(
          height: Const.containerHeight,
          width: (isRect) ? MediaQuery.of(context).size.width : Const.containerWidth,
          child: Opacity(
            opacity: 0.55,
            child: FloatingActionButton(
                backgroundColor: color,
                onPressed: () {},
                shape: _listItemShape,
            ),
          ),
        ),
      ),
    );
  }
}
