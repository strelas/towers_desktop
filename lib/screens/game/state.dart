abstract class GamePageState {
  factory GamePageState.preparing(int countOfRings) =>
      GamePageStatePreparing._(countOfRings);

  factory GamePageState.started({
    required bool isAutoMovesEnabled,
    required bool canStartAutoMoves,
    required int movesCount,
  }) =>
      GamePageStateStarted._(
        canStartAutoMoves: canStartAutoMoves,
        isAutoMovesEnabled: isAutoMovesEnabled,
        movesCount: movesCount,
      );
}

class GamePageStatePreparing implements GamePageState {
  final int countOfRings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamePageStatePreparing &&
          runtimeType == other.runtimeType &&
          countOfRings == other.countOfRings;

  @override
  int get hashCode => countOfRings.hashCode;

  const GamePageStatePreparing._(this.countOfRings);
}

class GamePageStateStarted implements GamePageState {
  final bool isAutoMovesEnabled;
  final bool canStartAutoMoves;
  final int movesCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamePageStateStarted &&
          runtimeType == other.runtimeType &&
          isAutoMovesEnabled == other.isAutoMovesEnabled &&
          canStartAutoMoves == other.canStartAutoMoves &&
          movesCount == other.movesCount;

  @override
  int get hashCode =>
      isAutoMovesEnabled.hashCode ^
      canStartAutoMoves.hashCode ^
      movesCount.hashCode;

  const GamePageStateStarted._({
    required this.canStartAutoMoves,
    required this.isAutoMovesEnabled,
    required this.movesCount,
  });

  GamePageStateStarted copyWith({
    bool? canStartAutoMoves,
    bool? isAutoMovesEnabled,
    int? movesCount
  }) =>
      GamePageStateStarted._(
        canStartAutoMoves: canStartAutoMoves ?? this.canStartAutoMoves,
        isAutoMovesEnabled: isAutoMovesEnabled ?? this.isAutoMovesEnabled,
        movesCount: movesCount ?? this.movesCount,
      );
}
