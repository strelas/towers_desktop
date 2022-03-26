import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:towers_desktop/entity/move.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/screens/game/board/state.dart';

class TowersBoardController extends Cubit<TowersState> {
  int? _ringsCount;
  int get ringsCount => _ringsCount ?? 0;
  final Function _onMoveDone;

  TowersBoardController(this._onMoveDone)
      : super(TowersState(List.generate(3, (index) => Queue())));

  startGameWith(int count) {
    final rings = List.generate(count, (index) {
      final width = 0.5 + 0.5 * (index + 1) / count;
      final height = 1.0 + 0.5 * (index + 1 - count / 2) / count;
      return RingModel(
        color: colors[index],
        height: height,
        width: width,
        selected: false,
        ring: Ring(index),
      );
    });
    _ringsCount = count;
    emit(TowersState([Queue.of(rings), Queue(), Queue()]));
  }

  select(int at) {
    final copy = state.copy();
    final index = state.board
        .indexWhere((element) => element.isNotEmpty && element.first.selected);
    if (index == -1) {
      final toSelect = copy.board[at].removeFirst();
      copy.board[at].addFirst(toSelect.copyWith(selected: true));
      emit(copy);
    } else {
      if (index != at) {
        move(Move(index, at));
      } else {
        final toSelect = copy.board[at].removeFirst();
        copy.board[at].addFirst(toSelect.copyWith(selected: false));
        emit(copy);
      }

    }
  }

  move(Move move) {
    final from = move.from;
    final to = move.to;
    final copy = state.copy();
    if (!copy.board[from].first.ring
        .canBePlacedOn(Queue.from(copy.board[to].map((e) => e.ring)))) {
      return;
    }
    _onMoveDone();
    copy.board[to].addFirst(
      copy.board[from].removeFirst().copyWith(
            selected: false,
          ),
    );
    emit(copy);
  }

  static const colors = <Color>[
    Colors.blueAccent,
    Colors.blue,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.indigoAccent,
    Colors.indigo
  ];
}
