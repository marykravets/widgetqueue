import 'package:flutter/material.dart';
import 'package:widgetqueue/res/ConstMethod.dart';
import 'helper/BaseUiMixin.dart';
import 'helper/ListViewHelper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with BaseUiMixin {

  @override
  Widget build(BuildContext context) {
    final ListViewHelper helper = new ListViewHelper(this);
    final appBar = AppBar(title: Text(widget.title!));
    final btnSpacing = SizedBox(height: 10);
    final btn4Spacing = SizedBox(height: 40);

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: buildReorderableListView(helper),
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getClearAllButton(helper),
            btn4Spacing,
            getClearButton(helper),
            btnSpacing,
            getUndoButton(helper),
            btnSpacing,
            getRedoButton(helper),
            btnSpacing,
            getAddButton(helper)
          ]
      ),
    );
  }

  ReorderableListView buildReorderableListView(ListViewHelper helper) {
    return ReorderableListView(
        children: getChildren(helper),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final List<StatelessWidget> secondList = List.from(
                helper.getLastListState());
            secondList.insert(newIndex, secondList.removeAt(oldIndex));

            helper.addNewState(secondList);
          });
        },
        scrollController: helper.getScrollController());
  }

  List<Widget> getChildren(ListViewHelper helper) {
    return <Widget>[
      for(int i = 0; i < helper
          .getLastListState()
          .length; i++)
        Dismissible(
          background: ConstMethod.getDismissibleBackground(),
          key: UniqueKey(),
          onDismissed: (direction) {
            // Remove the item from list
            setState(() {
              final List<StatelessWidget> secondList = List.from(
                  helper.getLastListState());
              secondList.removeAt(i);
              helper.addNewState(secondList);
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(ConstMethod.getDismissBar());
          },
          child: Center(
              child: helper.getLastListState().elementAt(i)
          ),
        ),
    ];
  }
}
