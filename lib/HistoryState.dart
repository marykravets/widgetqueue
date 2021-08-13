import 'dart:collection';
import 'package:flutter/material.dart';
import 'helper/ListState.dart';

class HistoryState {
  static late Queue<List<StatelessWidget>> _queue = Queue();
  static late ListState _listState = ListState();

  static final HistoryState _historyState = HistoryState._internal();

  factory HistoryState() {
    return _historyState;
  }

  HistoryState._internal();

  bool isQueueNotEmpty() {
    return _queue.isNotEmpty;
  }

  List<StatelessWidget> removeLastFromQueue() {
    return _queue.removeLast();
  }

  void addToQueue(List<StatelessWidget> list) {
    _queue.add(list);
  }

  int getQueueLen() {
    return _queue.length;
  }

  void clear() {
    clearQueue();
    _listState.clear();
  }

  void clearQueue() {
    _queue.clear();
  }

  int getStateLen() {
    return _listState.getLength();
  }

  void addToState(List<StatelessWidget> list) {
    _listState.add(list);
  }

  List<StatelessWidget> removeLast() {
    return _listState.removeLast();
  }

  List<StatelessWidget> getLastState() {
    return _listState.getLast();
  }

  int getLastStateLen() {
    return _listState.getLast().length;
  }

  bool isLastStateNotEmpty() {
    return _listState.getLast().isNotEmpty;
  }

  void addLastStateToQueue() {
    if (getStateLen() > 0) {
      addToQueue(removeLast());
    }
  }

  void addLastQueueToState() {
    if (isQueueNotEmpty()) {
      addToState(removeLastFromQueue());
    }
  }

  bool isClearActive() {
    return getLastStateLen() > 0 || getQueueLen() > 0;
  }

  bool isUndoActive() {
    return getLastStateLen() > 0 || getStateLen() > 0;
  }

  bool isRedoActive() {
    return getQueueLen() > 0;
  }

  void reorderState(int newIndex, int oldIndex) {
    final List<StatelessWidget> secondList = List.from(
        _historyState.getLastState());
    secondList.insert(newIndex, secondList.removeAt(oldIndex));
    _historyState.addToState(secondList);
  }

  void removeItemFromState(int index) {
    final List<StatelessWidget> secondList = List.from(
        _historyState.getLastState());
    secondList.removeAt(index);
    _historyState.addToState(secondList);
  }
}
