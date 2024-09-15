enum Priority {
  high("!!!","High",3),
  medium("!!","Medium",2),
  low("!","Low",1),
  none("","None",0);

  const Priority(this.priorityText,this.display,this.prioLevel);

  final String priorityText;
  final String display;
  final int prioLevel;
}

// https://syedabdulbasit7.medium.com/understanding-and-implementing-comparable-in-dart-33916f5f06cf
class Reminder implements Comparable<Reminder>{
  const Reminder({
    required this.name
    , required this.prio
    });

  final String name;
  final Priority prio;

  @override
  int compareTo(Reminder other) {
    return prio.prioLevel.compareTo(other.prio.prioLevel);
  }

}
