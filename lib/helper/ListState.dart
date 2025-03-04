import 'package:flutter/material.dart';

class ListStateInterface {
  void add(List<StatelessWidget> list) {}
  List<StatelessWidget>? removeLast() {}
  List<StatelessWidget>? getLast() {}
  int? getLength() {}
  void clear() {}
}

// class that memorizes list state
class ListState implements ListStateInterface {
  final List<List<StatelessWidget>> _list = [];
  final List<StatelessWidget> _emptyList = [];

  ListState();

  void add(List<StatelessWidget> list) {
    _list.add(list);
  }

  List<StatelessWidget> removeLast() {
    return _list.removeLast();
  }

  List<StatelessWidget> getLast() {
    return _list.isEmpty ? _emptyList : _list.last;
  }

  int getLength() {
    return _list.length;
  }

  void clear() {
    _list.clear();
  }
}
