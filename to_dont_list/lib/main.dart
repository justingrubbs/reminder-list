// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/reminder.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';
import 'package:collection/collection.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final reminders = PriorityQueue<Reminder>((a,b) => a.compareTo(b));
    
  final reminderSet = <Reminder>{};

  void handleListChanged(Reminder reminder, bool completed) {
    setState(() {

      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      reminders.remove(reminder);
      if (!completed) {
        print("Completing");
        reminderSet.add(reminder);
        reminders.add(reminder);
      } else {
        print("Making Undone");
        reminderSet.remove(reminder);
        reminders.add(reminder);
      }
    });
  }

  void handleDeleteReminder(Reminder reminder) {
    setState(() {
      print("Deleting reminder");
      reminders.remove(reminder);
    });
  }

  void handleNewReminder(String reminderText, Priority priority, TextEditingController textController) {
    setState(() {
      print("New reminder");
      Reminder reminder = Reminder(name: reminderText, prio: priority);
      reminders.add(reminder);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reminders"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: reminders.toList().map((reminder) {
            return ToDoListReminder(
              reminder: reminder,
              completed: reminderSet.contains(reminder),
              onListChanged: handleListChanged,
              onDeleteReminder: handleDeleteReminder,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: handleNewReminder);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: "Reminders",
    home: ToDoList(),
  ));
}
