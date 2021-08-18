import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import 'package:widgetqueue/widget/CustomButton.dart';
import 'package:widgetqueue/widget/RectButton.dart';
import 'helper/ListState.dart';

class HistoryState {
  // const of empty list to make sure the list created once (save some memory)
  final List<StatelessWidget> _emptyList = [];

  static late Queue<List<StatelessWidget>> _queue = Queue();
  static late ListState _listState = ListState();

  static final HistoryState _historyState = HistoryState._internal();

  factory HistoryState() {
    return _historyState;
  }

  HistoryState._internal();

  List<StatelessWidget> getLastState() {
    return _listState.getLast();
  }

  int getLastStateLen() {
    return _listState.getLast().length;
  }

  void undo() {
    if (_listState.getLength() > 0) {
      _queue.add(_listState.removeLast());
    }
  }

  void redo() {
    if (_queue.isNotEmpty) {
      _listState.add(_queue.removeLast());
    }
  }

  bool isClearActive() {
    return getLastStateLen() > 0 || _queue.length > 0;
  }

  bool isUndoActive() {
    return getLastStateLen() > 0 || _listState.getLength() > 0;
  }

  bool isRedoActive() {
    return _queue.length > 0;
  }

  void _reorderState(int newIndex, int oldIndex) {
    final List<StatelessWidget> secondList = List.from(
        getLastState());
    secondList.insert(newIndex, secondList.removeAt(oldIndex));
    _listState.add(secondList);
  }

  void _removeItemFromState(int index) {
    final List<StatelessWidget> secondList = List.from(
        getLastState());
    secondList.removeAt(index);
    _listState.add(secondList);
  }

  List<StatelessWidget> _getNewState() {
    // create a copy of the last state, add a change, return as a new state
    final List<StatelessWidget> _list = [];

    if (_listState.getLast().isNotEmpty) {
      _list.addAll(getLastState());
    }

    final Random random = Random();
    if (random.nextBool()) {
      _list.add(new CustomButton(ConstMethod.getRandomColor()));
    } else {
      _list.add(new RectButton(ConstMethod.getRandomColor()));
    }

    return _list;
  }

  void stateDo(StateAction action,
      {int newReorderIndex = 0, int oldReorderIndex = 0, int, itemToRemoveIndex = 0}) {
    switch(action) {
      case StateAction.Add:
        _queue.clear();
        _listState.add(_getNewState());
        break;

      case StateAction.Clean:
        _queue.clear();
        _listState.clear();
        break;

      case StateAction.ClearWidget:
        _listState.add(_emptyList);
        break;

      case StateAction.RemoveItem:
        _removeItemFromState(itemToRemoveIndex);
        break;

      case StateAction.Reorder:
        _reorderState(newReorderIndex, oldReorderIndex);
        break;
        
      default: break;
    }
  }
}

// list of actions supported in state
enum StateAction {
  Clean,
  Add,
  Reorder,
  ClearWidget,
  RemoveItem
}
