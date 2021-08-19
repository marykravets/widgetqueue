import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import 'package:widgetqueue/widget/CustomButton.dart';
import 'package:widgetqueue/widget/RectButton.dart';
import 'helper/ListState.dart';

class HistoryState with ChangeNotifier {
  // const of empty list to make sure the list created once (save some memory)
  static final List<StatelessWidget> _emptyList = [];

  static final Queue<List<StatelessWidget>> _queue = Queue();
  static final ListState _listState = ListState();

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
      notifyListeners();
    }
  }

  void redo() {
    if (_queue.isNotEmpty) {
      _listState.add(_queue.removeLast());
      notifyListeners();
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

  void addState() {
    _queue.clear();
    _listState.add(_getNewState());
    notifyListeners();
  }

  void clearAll() {
    _queue.clear();
    _listState.clear();
  }

  void clearState() {
    _listState.add(_emptyList);
  }

  void removeItem(int itemToRemoveIndex) {
    final List<StatelessWidget> secondList = List.from(
        getLastState());
    secondList.removeAt(itemToRemoveIndex);
    _listState.add(secondList);
  }

  void reorder(int newIndex, int oldIndex) {
    final List<StatelessWidget> secondList = List.from(
        getLastState());
    secondList.insert(newIndex, secondList.removeAt(oldIndex));
    _listState.add(secondList);
  }
}
