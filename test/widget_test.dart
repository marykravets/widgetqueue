import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetqueue/main.dart';
import 'package:widgetqueue/widget/BaseCustomButton.dart';

void main() {
  testWidgets('Widget is getting added -> 2 undo -> 2 redo -> clean all -> undo -> redo', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetQueueApp());
    expect(findCustomButton(), findsNothing);

    await tapAdd(tester);
    expect(findCustomButton(), findsOneWidget);

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await tapRedo(tester);
    expect(findCustomButton(), findsNWidgets(1));

    await tapRedo(tester);
    expect(findCustomButton(), findsNWidgets(1));

    await cleanup(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await tapRedo(tester);
    expect(findCustomButton(), findsNothing);

    await cleanup(tester);
  });

  testWidgets('3 widgets are getting added -> undo -> redo', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetQueueApp());
    expect(findCustomButton(), findsNothing);

    await tapAddNtimes(tester, 3);
    expect(findCustomButton(), findsNWidgets(3));

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(2));

    await tapRedo(tester);
    expect(findCustomButton(), findsNWidgets(3));

    await cleanup(tester);
  });

  testWidgets('2 widgets are getting added -> clean -> undo -> redo -> undo -> clean all -> undo', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetQueueApp());
    expect(findCustomButton(), findsNothing);

    await tapAdd(tester);
    await tapAdd(tester);
    expect(findCustomButton(), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.cleaning_services));
    await tester.pump();
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(2));

    await tapRedo(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(2));

    await cleanup(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);
  });

  testWidgets('3 widgets are getting added -> clean -> 1 widget added -> undo -> undo -> undo', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetQueueApp());
    expect(findCustomButton(), findsNothing);

    await tapAddNtimes(tester, 3);
    expect(findCustomButton(), findsNWidgets(3));

    await tester.tap(find.byIcon(Icons.cleaning_services));
    await tester.pump();
    expect(findCustomButton(), findsNothing);

    await tapAdd(tester);
    expect(findCustomButton(), findsNWidgets(1));

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(3));

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(2));

    await tapUndo(tester);
    expect(findCustomButton(), findsNWidgets(1));

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await tapUndo(tester);
    expect(findCustomButton(), findsNothing);

    await cleanup(tester);
  });

  testWidgets('15 widgets are getting added -> undo -> redo', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetQueueApp());
    expect(findCustomButton(), findsNothing);

    final int count = 15;

    await tapAddNtimes(tester, count);

    for(int i = 0; i < count; i++) {
      await tapUndo(tester);
    }
    expect(findCustomButton(), findsNothing);

    for(int i = 0; i < count + 5; i++) {
      await tapRedo(tester);
    }

    expect(findCustomButton(), findsNWidgets(count));
    await cleanup(tester);
  });
}

Future<void> tapRedo(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.redo));
  await tester.pump();
}

Future<void> tapUndo(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.undo));
  await tester.pump();
}

Future<void> tapAdd(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
}

Future<void> tapAddNtimes(WidgetTester tester, int count) async {
  for(int i = 0; i < count; i++) {
    await tapAdd(tester);
  }
}

Future<void> cleanup(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.clean_hands));
  await tester.pump();
}

Finder findCustomButton() {
  return find.byWidgetPredicate(
          (Widget widget) =>
      widget is BaseCustomButton
  );
}
