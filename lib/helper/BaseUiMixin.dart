import 'package:flutter/material.dart';
import 'package:widgetqueue/res/Const.dart';
import 'ListViewHelper.dart';

mixin BaseUiMixin {

  FloatingActionButton getAddButton(ListViewHelper helper) {
    return FloatingActionButton(
        onPressed: helper.addWidget,
        tooltip: Const.strAdd,
        child: const Icon(Icons.add)
    );
  }

  FloatingActionButton getUndoButton(ListViewHelper helper) {
    return FloatingActionButton(
        onPressed: helper.undoWidget,
        tooltip: Const.strUndo,
        child: const Icon(Icons.undo),
        backgroundColor: helper.getUndoBgColor()
    );
  }

  FloatingActionButton getRedoButton(ListViewHelper helper) {
    return FloatingActionButton(
        onPressed: helper.redoWidget,
        tooltip: Const.strRedo,
        child: const Icon(Icons.redo),
        backgroundColor: helper.getRedoBgColor()
    );
  }

  FloatingActionButton getClearButton(ListViewHelper helper) {
    return FloatingActionButton(
        onPressed: helper.clearWidget,
        tooltip: Const.strClear,
        child: const Icon(Icons.cleaning_services),
        backgroundColor: helper.getClearBgColor()
    );
  }

  FloatingActionButton getClearAllButton(ListViewHelper helper) {
    return FloatingActionButton(
        onPressed: helper.clearAll,
        tooltip: Const.strClearAll,
        child: const Icon(Icons.clean_hands),
        backgroundColor: helper.getClearBgColor()
    );
  }
}