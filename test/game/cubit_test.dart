import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/move.dart';
import 'package:towers_desktop/screens/game/cubit.dart';
import 'package:towers_desktop/screens/game/state.dart';

void main() {
  test('game cubit test', () async {
    final cubit = GameCubit();
    expect(cubit.state, GamePageState.preparing(1));
    cubit.decreaseRings();
    expect(cubit.state, GamePageState.preparing(1));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(2));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(3));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(4));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(5));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(6));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(7));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(8));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(9));
    cubit.increaseRings();
    expect(cubit.state, GamePageState.preparing(9));
    cubit.decreaseRings();
    expect(cubit.state, GamePageState.preparing(8));
    cubit.decreaseRings();
    expect(cubit.state, GamePageState.preparing(7));
    cubit.decreaseRings();
    expect(cubit.state, GamePageState.preparing(6));

    cubit.onStartGame();
    expect(
        cubit.state,
        GamePageState.started(
          isAutoMovesEnabled: false,
          canStartAutoMoves: true,
          movesCount: 0,
        ));

    cubit.enableAutoMoves();
    expect(
      cubit.state,
      GamePageState.started(
        isAutoMovesEnabled: true,
        canStartAutoMoves: true,
        movesCount: 0,
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    expect(
      cubit.state,
      GamePageState.started(
        isAutoMovesEnabled: true,
        canStartAutoMoves: true,
        movesCount: 1,
      ),
    );
    cubit.disableAutoMoves();
    expect(
      cubit.state,
      GamePageState.started(
        isAutoMovesEnabled: false,
        canStartAutoMoves: false,
        movesCount: 1,
      ),
    );

    cubit.boardController.move(const Move(0, 2));
    expect(
      cubit.state,
      GamePageState.started(
        isAutoMovesEnabled: false,
        canStartAutoMoves: false,
        movesCount: 2,
      ),
    );

    cubit.startNewGame();
    expect(cubit.state, GamePageState.preparing(1));
  });
}
