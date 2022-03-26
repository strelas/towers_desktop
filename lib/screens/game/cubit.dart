import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towers_desktop/screens/game/board/controller.dart';
import 'package:towers_desktop/screens/game/board/state.dart';
import 'package:towers_desktop/screens/game/state.dart';
import 'package:towers_desktop/towers/best_strategy.dart';
import 'package:towers_desktop/utils.dart';

class GameCubit extends Cubit<GamePageState> {
  @visibleForTesting
  late final TowersBoardController boardController =
      TowersBoardController(_onMoveDone);
  final BestStrategy _bestStrategy = BestStrategy();
  StreamSubscription? _subscription;

  List<BlocProvider> get providers => [
        BlocProvider<GameCubit>.value(value: this),
        BlocProvider<TowersBoardController>.value(value: boardController),
      ];

  GameCubit() : super(GamePageState.preparing(1));

  decreaseRings() {
    final safeState = state;
    if (safeState is GamePageStatePreparing && safeState.countOfRings > 1) {
      emit(GamePageState.preparing(max(safeState.countOfRings - 1, 1)));
    }
  }

  increaseRings() {
    final safeState = state;
    if (safeState is GamePageStatePreparing) {
      emit(GamePageState.preparing(min(safeState.countOfRings + 1, 9)));
    }
  }

  startNewGame() {
    emit(GamePageState.preparing(1));
  }

  enableAutoMoves() {
    final bestMovesStream = Stream.fromFutures(_bestStrategy
        .moveTower(0, 2, boardController.ringsCount, 1)
        .mapIndexed((index, value) =>
            Future.delayed(Duration(seconds: (index + 1) * 2), () => value)));
    _subscription = bestMovesStream.listen((move) {
      boardController.move(move);
    });
    final safeState = state;
    if (safeState is GamePageStateStarted) {
      emit(safeState.copyWith(
        isAutoMovesEnabled: true,
      ));
    }
  }

  disableAutoMoves() {
    _subscription?.cancel();
    final safeState = state;
    if (safeState is GamePageStateStarted) {
      emit(safeState.copyWith(
        canStartAutoMoves: false,
        isAutoMovesEnabled: false,
      ));
    }
  }

  onStartGame() {
    final safeState = state;
    if (safeState is GamePageStatePreparing) {
      boardController.startGameWith(safeState.countOfRings);
      emit(
        GamePageState.started(
          isAutoMovesEnabled: false,
          canStartAutoMoves: true,
          movesCount: 0,
        ),
      );
    }
  }

  _onMoveDone() {
    final safeState = state;
    if (safeState is GamePageStateStarted) {
      emit(safeState.copyWith(movesCount: safeState.movesCount + 1));
    }
  }
}
