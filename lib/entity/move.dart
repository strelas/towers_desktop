class Move {
  final int from;
  final int to;

  const Move(this.from, this.to);

  Move reversed() => Move(to, from);
}
