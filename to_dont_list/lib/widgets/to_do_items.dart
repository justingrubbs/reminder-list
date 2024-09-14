import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/reminder.dart';

typedef ToDoListChangedCallback = Function(Reminder reminder, bool completed);
typedef ToDoListRemovedCallback = Function(Reminder reminder);

class ToDoListReminder extends StatelessWidget {
  ToDoListReminder(
      {required this.reminder,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteReminder})
      : super(key: ObjectKey(reminder));

  final Reminder reminder;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteReminder;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(reminder, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteReminder(reminder);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: completed ? Colors.black54 : _getColor(context),
        child: Text(reminder.prio.priorityText),
      ),
      title: Text(
        reminder.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
