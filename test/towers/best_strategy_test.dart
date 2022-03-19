import 'dart:collection';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/towers/best_strategy.dart';

void main() {
  test(
    'best strategy test',
    () {
      for (final i in List.generate(BestStrategy.maxCount, (index) => index + 1)) {
        final matcher = List.generate(i, (index) => Ring(index));
        List<Queue<Ring>> board = [Queue.of(matcher), Queue(), Queue()];

        final strategy = BestStrategy();
        const from = 0;
        const to = 2;
        const buffer = 1;
        final moves = strategy.moveTower(from, to, i, buffer);

        var flag = true;
        for (final move in moves) {
          final ring = board[move.from].removeFirst();
          if (!ring.canBePlacedOn(board[move.to])) {
            flag = false;
            break;
          }
          board[move.to].addFirst(ring);
        }
        expect(flag, true); // test that all moves are possible
        expect(
          moves.length,
          pow(2, i) - 1,
        ); // test that this is the best strategy
        expect(board[to], Queue.of(matcher)); // test that end state is correct
      }
    },
  );
}
