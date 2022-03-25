import 'dart:core';

import 'package:towers_desktop/entity/move.dart';

class BestStrategy {
  static const int maxCount = 9;

  List<Move> moveTower(int from, int to, int count, int buffer) {
    if (count == 1) {
      return [Move(from, to)];
    }
    final result = moveTower(from, buffer, count - 1, to);
    result.add(Move(from, to));
    result.addAll(moveTower(buffer, to, count - 1, from));
    return result;
  }
}
