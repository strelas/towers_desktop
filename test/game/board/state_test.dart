import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/screens/game/board/state.dart';

void main() {
  test('Towers state test', () {
    final actual = TowersState([
      Queue.from(const [Ring(1), Ring(2), Ring(3)].map((e) => RingModel(
          color: Colors.black, height: 1, width: 1, selected: false, ring: e))),
      Queue(),
      Queue(),
    ]);

    final equals = TowersState([
      Queue.from(const [Ring(1), Ring(2), Ring(3)].map((e) => RingModel(
          color: Colors.black, height: 1, width: 1, selected: false, ring: e))),
      Queue(),
      Queue(),
    ]);
    expect(actual == equals, true);
    expect(actual.hashCode, equals.hashCode);

    final notEquals = TowersState([
      Queue.from(const [Ring(2), Ring(3)].map((e) => RingModel(
          color: Colors.black, height: 1, width: 1, selected: false, ring: e))),
      Queue.from(const [
        Ring(1),
      ].map((e) => RingModel(
              color: Colors.black,
              height: 1,
              width: 1,
              selected: false,
              ring: e)
          .copyWith(selected: false))),
      Queue(),
    ]);

    expect(actual == notEquals, false);
  });

  test('Ring model test', () {
    const actual = RingModel(
      color: Colors.black,
      height: 1,
      width: 1,
      selected: false,
      ring: Ring(0),
    );
    expect(actual.selected, false);
    expect(actual.copyWith().selected, false);
    expect(actual.copyWith(selected: true).selected, true);
  });
}
