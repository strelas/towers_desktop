import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/ring.dart';

void main() {
  test('ring test', () {
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
}
