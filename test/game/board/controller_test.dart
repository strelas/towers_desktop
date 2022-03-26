import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/screens/game/board/controller.dart';
import 'package:towers_desktop/screens/game/board/state.dart';

void main() {
  test('towers controller test', () {
    final controller = TowersBoardController(() {});
    expect(controller.state, TowersState([Queue(), Queue(), Queue()]));
    controller.startGameWith(3);
    var state = controller.state;
    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.ring).toList(),
        const [
          Ring(0),
          Ring(1),
          Ring(2),
        ],
      ),
      true,
    );
    expect(state.board[1].isEmpty, true);
    expect(state.board[2].isEmpty, true);
    controller.select(0);
    state = controller.state;
    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.selected).toList(),
        [
          true,
          false,
          false,
        ],
      ),
      true,
    );

    expect(state.board[1].isEmpty, true);
    expect(state.board[2].isEmpty, true);
    controller.select(0);
    state = controller.state;
    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.selected).toList(),
        [
          false,
          false,
          false,
        ],
      ),
      true,
    );
    controller.select(0);
    state = controller.state;
    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.selected).toList(),
        [
          true,
          false,
          false,
        ],
      ),
      true,
    );
    controller.select(1);
    state = controller.state;
    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.ring).toList(),
        const [Ring(1), Ring(2)],
      ),
      true,
    );
    expect(
      const ListEquality().equals(
        state.board[1].map((e) => e.ring).toList(),
        const [Ring(0)],
      ),
      true,
    );
    expect(state.board[1].first.selected, false);
    expect(state.board[2].isEmpty, true);

    controller.select(0);
    controller.select(2);
    controller.select(1);
    controller.select(2);

    state = controller.state;

    expect(
      const ListEquality().equals(
        state.board[0].map((e) => e.ring).toList(),
        const [Ring(2)],
      ),
      true,
    );
    expect(state.board[1].isEmpty, true);
    expect(
      const ListEquality().equals(
        state.board[2].map((e) => e.ring).toList(),
        const [Ring(0), Ring(1)],
      ),
      true,
    );
  });
}
