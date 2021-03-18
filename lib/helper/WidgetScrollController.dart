import 'package:flutter/material.dart';
import '../res/Const.dart';

class WidgetScrollController extends ScrollController {

  void scrollToEnd() {
    animateTo(
      position.maxScrollExtent + Const.containerHeight,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}