import 'dart:collection';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import '../widget/CustomButton.dart';
import '../HomePage.dart';
import '../widget/RectButton.dart';
import 'ListState.dart';
import 'WidgetScrollController.dart';

class ListViewHelper {

  static final ListViewHelper _helper = ListViewHelper._internal();
  ListViewHelper._internal();

  // singleton
  factory ListViewHelper(HomePageState s) {
    _helper._state = s;
    return _helper;
  }

  static final _scrollController = WidgetScrollController();
  static final Queue<List<StatelessWidget>> _queue = Queue();
  static final ListState _listState = ListState();
  late HomePageState _state;

  List<StatelessWidget> getLastListState() {
    return _listState.getLast();
  }

  void addWidget() {
    _queue.clear();
    // add a new state to the end of main state
    _listState.add(_getNewState());
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  List<StatelessWidget> _getNewState() {
    // create a copy of the last state, add a change, return as a new state
    final List<StatelessWidget> _list = [];

    if (_listState
        .getLast()
        .isNotEmpty) {
      _list.addAll(_listState.getLast());
    }

    final Random random = Random();
    if (random.nextBool()) {
      _list.add(new CustomButton(ConstMethod.getRandomColor()));
    } else {
      _list.add(new RectButton(ConstMethod.getRandomColor()));
    }

    return _list;
  }

  void undoWidget() {
    if (_listState.getLength() > 0) {
      _queue.add(_listState.removeLast());
    }
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  void redoWidget() {
    if (_queue.isNotEmpty) {
      _listState.add(_queue.removeLast());
    }
    _scrollController.scrollToEnd();

    _state.setState(() {});
  }

  void clearWidget() {
    _listState.add([]);

    _state.setState(() {});
  }

  void clearAll() {
    _queue.clear();
    _listState.clear();

    _state.setState(() {});
  }

  void addNewState(List<StatelessWidget> list) {
    _listState.add(list);
  }

  MaterialColor getRedoBgColor() =>
      ConstMethod.getButtonColor(_queue.length > 0);

  MaterialColor getUndoBgColor() =>
      ConstMethod.getButtonColor(_listState
          .getLast()
          .length > 0 || _listState.getLength() > 0);

  MaterialColor getClearBgColor() =>
      ConstMethod.getButtonColor(_listState
          .getLast()
          .length > 0 || _queue.length > 0);

  getScrollController() {
    return _scrollController;
  }
}
