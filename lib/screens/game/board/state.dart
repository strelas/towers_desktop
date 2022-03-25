import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/utils.dart';

class TowersState {
  final List<Queue<RingModel>> board;

  const TowersState(this.board) : assert(board.length == 3);

  @override
  bool operator ==(Object other) {
    if (other is! TowersState) {
      return false;
    }
    final firstLine = board[0];
    final secondLine = board[1];
    final thirdLine = board[2];

    if (!const ListEquality()
        .equals(firstLine.toList(), other.board[0].toList())) {
      return false;
    }

    if (!const ListEquality()
        .equals(secondLine.toList(), other.board[1].toList())) {
      return false;
    }

    if (!const ListEquality()
        .equals(thirdLine.toList(), other.board[2].toList())) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      const ListEquality().hash(board[0].toList()) ^
      const ListEquality().hash(board[1].toList()) ^
      const ListEquality().hash(board[2].toList());

  TowersState copy() => TowersState(board.copy().map((e) => e.copy()).toList());
}

class RingModel {
  final Color color;
  final double height;
  final double width;
  final bool selected;
  final Ring ring;

  const RingModel(
      {required this.color,
      required this.height,
      required this.width,
      required this.selected,
      required this.ring});

  RingModel copyWith({bool? selected}) => RingModel(
        color: color,
        height: height,
        width: width,
        selected: selected ?? this.selected,
        ring: ring,
      );
}
