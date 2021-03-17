import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'Const.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final _random = new Random();
  static final _scrollController = new ScrollController();
  static final List<CustomButton> _list = [];
  static final Queue<CustomButton> _queue = new Queue();

  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + Const.containerHeight,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _addWidget() {
    _list.add(new CustomButton(getRandomColor()));
    scrollToEnd();

    setState(() {});
  }

  void _undoWidget() {
    _queue.add(_list.removeLast());
    scrollToEnd();

    setState(() {});
  }

  void _redoWidget() {
    _list.add(_queue.removeLast());
    scrollToEnd();

    setState(() {});
  }

  void _clearWidget() {
    _list.clear();
    _queue.clear();

    setState(() {});
  }

  getRandomColor() => Const.colors[_random.nextInt(Const.colors.length)];

  MaterialColor getRedoBgColor() => _queue.length > 0 ? Colors.blue : Colors.grey;

  MaterialColor getUndoBgColor() => _list.length > 0 ? Colors.blue : Colors.grey;

  MaterialColor getClearBgColor() => (_list.length > 0 || _queue.length > 0) ? Colors.blue : Colors.grey;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(widget.title));

    final listView = new ListView.builder(itemCount: _list.length,
        itemBuilder: (_, index) => _list[index],
        controller: _scrollController);

    final actionButton = FloatingActionButton(
        onPressed: _addWidget,
        tooltip: Const.strAdd,
        child: Icon(Icons.add)
    );

    final undoButton = FloatingActionButton(
        onPressed: _undoWidget,
        tooltip: Const.strUndo,
        child: Icon(Icons.undo),
        backgroundColor: getUndoBgColor()
    );

    final redoButton = FloatingActionButton(
        onPressed: _redoWidget,
        tooltip: Const.strRedo,
        child: Icon(Icons.redo),
        backgroundColor: getRedoBgColor()
    );

    final clearButton = FloatingActionButton(
        onPressed: _clearWidget,
        tooltip: Const.strClear,
        child: Icon(Icons.cleaning_services),
        backgroundColor: getClearBgColor()
    );

    final actionBtnSpacing = SizedBox(height: 10);

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: listView
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            clearButton,
            actionBtnSpacing,
            undoButton,
            actionBtnSpacing,
            redoButton,
            actionBtnSpacing,
            actionButton
          ]
      ),
    );
  }
}