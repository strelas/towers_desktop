import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/ring.dart';

void main() {
  test('ring canBePlacedOn test', () {
    const ring = Ring(3);
    final correctQueue = Queue.of([
      const Ring(4),
      const Ring(6),
      const Ring(9),
    ]);

    expect(ring.canBePlacedOn(correctQueue), true);

    final incorrectQueue = Queue.of([
      const Ring(2),
      const Ring(4),
      const Ring(6),
    ]);

    expect(ring.canBePlacedOn(incorrectQueue), false);
  });

  test('ring equals and hashcode test', () {
    const actual = Ring(3);
    const equal = Ring(3);

    expect(actual, equal);
    expect(actual.hashCode, equal.hashCode);

    const notEqual1 = Ring(1);
    const notEqual2 = Ring(2);
    const notEqual3 = Ring(4);
    const notEqual4 = Ring(5);

    expect(actual == notEqual1, false);
    expect(actual == notEqual2, false);
    expect(actual == notEqual3, false);
    expect(actual == notEqual4, false);
  });
}
