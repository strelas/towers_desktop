import 'dart:collection';

class Ring {
  final int weight;

  const Ring(this.weight);

  bool canBePlacedOn(Queue<Ring> tower) =>
      tower.isEmpty || weight < tower.first.weight;

  @override
  bool operator ==(Object other) {
    if (other is! Ring) {
      return false;
    }
    return other.weight == weight;
  }

  @override
  int get hashCode => weight.hashCode;
}
