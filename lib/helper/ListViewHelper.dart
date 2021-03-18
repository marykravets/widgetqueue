import 'dart:collection';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../res/Const.dart';
import '../widget/CustomButton.dart';
import '../HomePage.dart';
import '../widget/RectButton.dart';
import 'WidgetScrollController.dart';

class ListViewHelper {

  static final _scrollController = new WidgetScrollController();
  static final List<StatelessWidget> _list = [];
  static final Queue<StatelessWidget> _queue = new Queue();
  HomePageState _state;

  ListViewHelper(HomePageState state) {
    _state = state;
  }

  void addWidget() {
    _queue.clear();
    addRandomWidget();
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  void addRandomWidget() {
     final Random random = new Random();
    
    if(random.nextBool()) {
      _list.add(new CustomButton(Const.getRandomColor()));
    } else {
      _list.add(new RectButton(Const.getRandomColor()));
    }
  }

  void undoWidget() {
    _queue.add(_list.removeLast());
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  void redoWidget() {
    _list.add(_queue.removeLast());
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  void clearWidget() {
    _list.clear();
    _queue.clear();

    _state.setState(() {});
  }

  MaterialColor getRedoBgColor() => _queue.length > 0 ? Colors.blue : Colors.grey;

  MaterialColor getUndoBgColor() => _list.length > 0 ? Colors.blue : Colors.grey;

  MaterialColor getClearBgColor() => (_list.length > 0 || _queue.length > 0) ? Colors.blue : Colors.grey;

  ListView getListView() {
    return new ListView.builder(itemCount: _list.length,
        itemBuilder: (_, index) => _list[index],
        controller: _scrollController);
  }
}