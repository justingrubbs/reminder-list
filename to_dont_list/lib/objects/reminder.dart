enum Priority {
  high,
  medium,
  low,
  none;

  const Priority();
}

class Reminder {
  const Reminder({
    required this.name
    // , required this.prio
    // , required this.date
    });

  final String name;
  // final Priority prio;
  // final DateTime date;

  String abbrev() {
    return name.substring(0, 1);
  }
}
