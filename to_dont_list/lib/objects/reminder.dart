enum Priority {
  high(),
  medium(),
  low(),
  none();

  const Priority();
}

class Reminder {
  const Reminder({
    required this.text
    , required this.prio
    , required this.date
    });

  final String text;
  final Priority prio;
  final DateTime date;

  String abbrev() {
    return text.substring(0, 1);
  }
}
