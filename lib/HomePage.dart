import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetqueue/res/Const.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import 'package:widgetqueue/widget/CustomButton.dart';
import 'package:widgetqueue/widget/RectButton.dart';
import 'helper/ListState.dart';
import 'helper/WidgetScrollController.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  static final _scrollController = WidgetScrollController();
  static final Queue<List<StatelessWidget>> _queue = Queue();
  static final ListState _listState = ListState();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text(widget.title!),
        backgroundColor: Colors.black12,
    );
    final btnSpacing = const SizedBox(height: 10);
    final btn4Spacing = const SizedBox(height: 40);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Center(
        child: buildReorderableListView(),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getClearAllButton(),
            btn4Spacing,
            getClearButton(),
            btnSpacing,
            getUndoButton(),
            btnSpacing,
            getRedoButton(),
            btnSpacing,
            getAddButton()
          ]
      ),
    );
  }

  ReorderableListView buildReorderableListView() {
    return ReorderableListView(
        children: getChildren(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final List<StatelessWidget> secondList = List.from(
                _listState.getLast());
            secondList.insert(newIndex, secondList.removeAt(oldIndex));
            _listState.add(secondList);
          });
        },
        scrollController: _scrollController);
  }

  List<Widget> getChildren() {
    final int lastStateLength = _listState.getLast().length;
    return <Widget>[
      for(int i = 0; i < lastStateLength; i++)
        Dismissible(
          background: ConstMethod.getDismissibleBackground(),
          key: UniqueKey(),
          onDismissed: (direction) {
            // Remove the item from list
            setState(() {
              final List<StatelessWidget> secondList = List.from(
                  _listState.getLast());
              secondList.removeAt(i);
              _listState.add(secondList);
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(ConstMethod.getDismissBar());
          },
          child: Center(
              child: _listState.getLast().elementAt(i)
          ),
        ),
    ];
  }

  //#region Helper UI

  void addWidget() {
    setState(() {
      _queue.clear();
      // add a new state to the end of main state
      _listState.add(_getNewState());
      _scrollController.scrollToEnd();
    });
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
    setState(() {
      if (_listState.getLength() > 0) {
        _queue.add(_listState.removeLast());
      }
      _scrollController.scrollToEnd();
    });
  }

  void redoWidget() {
    setState(() {
      if (_queue.isNotEmpty) {
        _listState.add(_queue.removeLast());
      }
      _scrollController.scrollToEnd();
    });
  }

  void clearWidget() {
    setState(() {
      _listState.add([]);
    });
  }

  void clearAll() {
    setState(() {
      _queue.clear();
      _listState.clear();
    });
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

  FloatingActionButton getAddButton() {
    return FloatingActionButton(
        onPressed: addWidget,
        tooltip: Const.strAdd,
        child: const Icon(Icons.add)
    );
  }

  FloatingActionButton getUndoButton() {
    return FloatingActionButton(
        onPressed: undoWidget,
        tooltip: Const.strUndo,
        child: const Icon(Icons.undo),
        backgroundColor: getUndoBgColor()
    );
  }

  FloatingActionButton getRedoButton() {
    return FloatingActionButton(
        onPressed: redoWidget,
        tooltip: Const.strRedo,
        child: const Icon(Icons.redo),
        backgroundColor: getRedoBgColor()
    );
  }

  FloatingActionButton getClearButton() {
    return FloatingActionButton(
        onPressed: clearWidget,
        tooltip: Const.strClear,
        child: const Icon(Icons.cleaning_services),
        backgroundColor: getClearBgColor()
    );
  }

  FloatingActionButton getClearAllButton() {
    return FloatingActionButton(
        onPressed: clearAll,
        tooltip: Const.strClearAll,
        child: const Icon(Icons.clean_hands),
        backgroundColor: getClearBgColor()
    );
  }

  //#endregion
}
