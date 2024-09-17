// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/reminder.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test("Priority level of High should be 0", () {
    const reminder = Reminder(name: "Homework",prio: Priority.high);
    expect(reminder.prio.prioLevel, 0);
  });

    test("Priority level is correctly compared", () {
    const reminder = Reminder(name: "Homework",prio: Priority.high);
    const reminder2 = Reminder(name: "Nap", prio: Priority.low);
    const reminder3 = Reminder(name: "Exercise",prio: Priority.medium);

    expect(reminder.compareTo(reminder2),-1);
    expect(reminder2.compareTo(reminder3),1);
    expect(reminder.compareTo(reminder3),-1);
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListReminder has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListReminder(
                reminder: const Reminder(name: "test",prio: Priority.low),
                completed: true,
                onListChanged: (Reminder item, bool completed) {},
                onDeleteReminder: (Reminder item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListReminder(
                reminder: const Reminder(name: "test",prio: Priority.medium),
                completed: true,
                onListChanged: (Reminder item, bool completed) {},
                onDeleteReminder: (Reminder item) {}))));
    final abbvFinder = find.text("!!");
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(circ.backgroundColor, Colors.black54);
    expect(ctext.data, "!!");
  });

  testWidgets('Default ToDoList has no items', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(ToDoListReminder);

    expect(listItemFinder, findsNothing);
  });

}
