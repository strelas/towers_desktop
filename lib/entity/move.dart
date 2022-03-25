class Move {
  final int from;
  final int to;

  const Move(this.from, this.to);

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Move &&
  //         runtimeType == other.runtimeType &&
  //         from == other.from &&
  //         to == other.to;
  //
  // @override
  // int get hashCode => from.hashCode ^ to.hashCode;
}
