enum Priority {
  high("!!!","High"),
  medium("!!","Medium"),
  low("!","Low"),
  none("","None");

  const Priority(this.priorityText,this.display);

  final String priorityText;
  final String display;
}

class Reminder {
  const Reminder({
    required this.name
    , required this.prio
    });

  final String name;
  final Priority prio;

  String abbrev() {
    return name.substring(0, 1);
  }
}
