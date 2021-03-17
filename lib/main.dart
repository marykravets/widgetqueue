import 'package:flutter/material.dart';
import 'package:widgetqueue/HomePage.dart';
import 'Const.dart';

void main() => runApp(WidgetQueueApp());

class WidgetQueueApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Const.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: Const.pageTitle),
    );
  }
}
