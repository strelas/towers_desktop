import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/screens/game/state.dart';

void main() {
  test('preparing game page state hashcode and equals test', () {
    final actual = GamePageState.preparing(1);

    final equal = GamePageState.preparing(1);
    expect(actual, equal);
    expect(actual.hashCode, equal.hashCode);

    for (int i = 2; i < 10; i++) {
      expect(actual == GamePageState.preparing(i), false);
    }
  });

  test('started game page state hashcode and equals test', () {
    final actual = GamePageState.started(
      isAutoMovesEnabled: false,
      canStartAutoMoves: false,
      movesCount: 0,
    );

    final equal = GamePageState.started(
      isAutoMovesEnabled: false,
      canStartAutoMoves: false,
      movesCount: 0,
    );

    expect(actual, equal);
    expect(actual.hashCode, equal.hashCode);

    final notEqual1 = GamePageState.started(isAutoMovesEnabled: false, canStartAutoMoves: false, movesCount: 1);
    final notEqual2 = GamePageState.started(isAutoMovesEnabled: false, canStartAutoMoves: true, movesCount: 0);
    final notEqual3 = GamePageState.started(isAutoMovesEnabled: true, canStartAutoMoves: false, movesCount: 0);
    final notEqual4 = GamePageState.started(isAutoMovesEnabled: true, canStartAutoMoves: true, movesCount: 3);

    expect(actual == notEqual1, false);
    expect(actual == notEqual2, false);
    expect(actual == notEqual3, false);
    expect(actual == notEqual4, false);
  });
}
