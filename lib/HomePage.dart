import 'package:flutter/material.dart';
import 'package:widgetqueue/res/Const.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import 'package:widgetqueue/HistoryState.dart';
import 'helper/WidgetScrollController.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  static final _scrollController = WidgetScrollController();
  static final _historyState = HistoryState();

  static const _btnSpacing = const SizedBox(height: 10);
  static const _btn4Spacing = const SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title!),
      backgroundColor: Colors.black12,
    );

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
            _btn4Spacing,
            getClearButton(),
            _btnSpacing,
            getUndoButton(),
            _btnSpacing,
            getRedoButton(),
            _btnSpacing,
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
            _historyState.stateDo(
                _historyState.reorder, newReorderIndex: newIndex,
                oldReorderIndex: oldIndex);
          });
        },
        scrollController: _scrollController);
  }

  List<Widget> getChildren() {
    final int lastStateLength = _historyState.getLastStateLen();
    return <Widget>[
      for(int i = 0; i < lastStateLength; i++)
        Dismissible(
          background: ConstMethod.getDismissibleBackground(),
          key: UniqueKey(),
          onDismissed: (direction) {
            // Remove the item from list
            setState(() {
              _historyState.stateDo(
                  _historyState.removeItem, itemToRemoveIndex: i);
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(ConstMethod.getDismissBar());
          },
          child: Center(
              child: _historyState.getLastState().elementAt(i)
          ),
        ),
    ];
  }

  //#region Helper UI

  void addWidget() {
    setState(() {
      // add a new state to the end of main state
      _historyState.stateDo(_historyState.add);
      _scrollController.scrollToEnd();
    });
  }

  void undoWidget() {
    setState(() {
      _historyState.undo();
      _scrollController.scrollToEnd();
    });
  }

  void redoWidget() {
    setState(() {
      _historyState.redo();
      _scrollController.scrollToEnd();
    });
  }

  void clearWidget() {
    setState(() {
      _historyState.stateDo(_historyState.clearWidget);
    });
  }

  void clearAll() {
    setState(() {
      _historyState.stateDo(_historyState.clear);
    });
  }

  MaterialColor getRedoBgColor() =>
      ConstMethod.getButtonColor(_historyState.isRedoActive());

  MaterialColor getUndoBgColor() =>
      ConstMethod.getButtonColor(_historyState.isUndoActive());

  MaterialColor getClearBgColor() =>
      ConstMethod.getButtonColor(_historyState.isClearActive());

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
