import 'package:flutter/material.dart';
import 'res/Const.dart';
import 'helper/ListViewHelper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final ListViewHelper helper = new ListViewHelper(this);
    final appBar = AppBar(title: Text(widget.title));

    final actionButton = FloatingActionButton(
        onPressed: helper.addWidget,
        tooltip: Const.strAdd,
        child: Icon(Icons.add)
    );

    final undoButton = FloatingActionButton(
        onPressed: helper.undoWidget,
        tooltip: Const.strUndo,
        child: Icon(Icons.undo),
        backgroundColor: helper.getUndoBgColor()
    );

    final redoButton = FloatingActionButton(
        onPressed: helper.redoWidget,
        tooltip: Const.strRedo,
        child: Icon(Icons.redo),
        backgroundColor: helper.getRedoBgColor()
    );

    final clearButton = FloatingActionButton(
        onPressed: helper.clearWidget,
        tooltip: Const.strClear,
        child: Icon(Icons.cleaning_services),
        backgroundColor: helper.getClearBgColor()
    );

    final clearAllButton = FloatingActionButton(
        onPressed: helper.clearAll,
        tooltip: Const.strClearAll,
        child: Icon(Icons.clean_hands),
        backgroundColor: helper.getClearBgColor()
    );

    final btnSpacing = SizedBox(height: 10);

    final btn4Spacing = SizedBox(height: 40);

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: helper.getListView()
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            clearAllButton,
            btn4Spacing,
            clearButton,
            btnSpacing,
            undoButton,
            btnSpacing,
            redoButton,
            btnSpacing,
            actionButton
          ]
      ),
    );
  }
}
