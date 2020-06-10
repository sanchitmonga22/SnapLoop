enum LoopType { NEW_LOOP, NEW_NOTIFICATION, EXISTING_LOOP, INACTIVE_LOOP }

class Loop {
  final String name;
  final int numberOfMembers;
  final LoopType type;
  const Loop({this.name, this.numberOfMembers, this.type});
}
