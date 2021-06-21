import 'package:flutter/material.dart';
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
        child: helper.getListView()
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
}
