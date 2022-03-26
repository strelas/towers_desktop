import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/screens/game/board/board.dart';
import 'package:towers_desktop/screens/game/cubit.dart';
import 'package:towers_desktop/screens/game/game_page.dart';
import 'package:towers_desktop/screens/game/state.dart';

void main() {
  testWidgets('game page test', (tester) async {
    final cubit = GameCubit();
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: cubit.providers,
          child: const GamePage(),
        ),
      ),
    );
    final startButton = find.text("Начать игру");
    await tester.tap(startButton);

    expect(cubit.boardController.state.board[0].length, 1);
    expect(cubit.boardController.state.board[1].length, 0);
    expect(cubit.boardController.state.board[2].length, 0);
    expect(cubit.state is GamePageStateStarted, true);
    await tester.pump();
    await tester.tap(find.byKey(Towers.firstColumnKey));
    await tester.tap(find.byKey(Towers.secondColumnKey));
    expect(cubit.boardController.state.board[0].length, 0);
    expect(cubit.boardController.state.board[1].length, 1);
    expect(cubit.boardController.state.board[2].length, 0);
    await tester.pump();
    await tester.tap(find.byKey(Towers.secondColumnKey));
    await tester.tap(find.byKey(Towers.thirdColumnKey));
    expect(cubit.boardController.state.board[0].length, 0);
    expect(cubit.boardController.state.board[1].length, 0);
    expect(cubit.boardController.state.board[2].length, 1);
    await tester.pump();
    await tester.tap(find.byKey(Towers.thirdColumnKey));
    await tester.pump();
    expect(cubit.boardController.state.board[2].first.selected, true);
    await tester.tap(find.text("Начать новую игру"));
    await tester.pump();
    expect(cubit.state is GamePageStatePreparing, true);
    final plus = tester.getTopRight(find.byKey(GamePage.counterKey));
    await tester.tapAt(plus.translate(-1, 1));
    await tester.pump();
    expect((cubit.state as GamePageStatePreparing).countOfRings, 2);
    final minus = tester.getTopLeft(find.byKey(GamePage.counterKey));
    await tester.tapAt(minus.translate(1, 1));
    await tester.pump();
    expect((cubit.state as GamePageStatePreparing).countOfRings, 1);

    await tester.tapAt(plus.translate(-1, 1));
    await tester.pump();
    await tester.tapAt(plus.translate(-1, 1));
    await tester.pump();
    await tester.tapAt(plus.translate(-1, 1));
    await tester.pump();
    await tester.tapAt(plus.translate(-1, 1));
    await tester.pump();
    expect((cubit.state as GamePageStatePreparing).countOfRings, 5);
    await tester.tap(find.text("Начать игру"));
    await tester.pump();
    await tester.tap(find.byKey(GamePage.switchKey));
    await tester.pump();
    expect((cubit.state as GamePageStateStarted).isAutoMovesEnabled, true);
    await tester.pump(const Duration(seconds: 62));
    expect(cubit.boardController.state.board[2].length, 5);
    await tester.tap(find.byKey(GamePage.switchKey));
    await tester.pump();
    expect((cubit.state as GamePageStateStarted).isAutoMovesEnabled, false);
    expect((cubit.state as GamePageStateStarted).canStartAutoMoves, false);
    expect((cubit.state as GamePageStateStarted).movesCount, 31);

    cubit.emit(UnexpectedState());
    await tester.pump();
    expect(find.text("Ошибка состояния"), findsOneWidget);
  });
}

class UnexpectedState implements GamePageState {}