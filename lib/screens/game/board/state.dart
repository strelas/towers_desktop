import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:towers_desktop/entity/ring.dart';
import 'package:towers_desktop/utils.dart';

class TowersState {
  final List<Queue<RingModel>> board;

  const TowersState(this.board) : assert(board.length == 3);

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
