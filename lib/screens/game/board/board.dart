import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towers_desktop/screens/game/board/controller.dart';
import 'package:towers_desktop/screens/game/board/state.dart';

class Towers extends StatelessWidget {
  static const firstColumnKey = Key("firstColumnKey");
  static const secondColumnKey = Key("secondColumnKey");
  static const thirdColumnKey = Key("thirdColumnKey");

  const Towers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TowersBoardController>();
    return BlocBuilder<TowersBoardController, TowersState>(
      bloc: controller,
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          final maxWidth = constraints.maxWidth / 3;
          final maxHeight = constraints.maxHeight *
              4 /
              9 /
              state.board.fold(0,
                  (previousValue, element) => previousValue + element.length);
          return Stack(
            children: [
              Positioned.fill(child: buildColumns(context)),
              ...buildRings(context, state, maxWidth, maxHeight),
              Positioned.fill(child: buildSelectable(context)),
            ],
          );
        });
      },
    );
  }

  Widget buildColumns(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
              ),
              Container(
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
              ),
              Container(
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildRings(BuildContext context, TowersState state,
      double maxWidth, double maxHeight) {
    final result = <Widget>[];
    const duration = Duration(seconds: 1);
    result.addAll(state.board[0].mapIndexed((index, element) {
      return AnimatedPositioned(
        curve: Curves.linearToEaseOut,
        key: Key("Ring ${element.ring.weight}"),
        left: 0,
        width: maxWidth,
        height: element.height * maxHeight,
        bottom: getBottomPadding(index, maxHeight, state.board[0].toList()),
        child: buildRing(element, maxWidth, maxHeight),
        duration: duration,
      );
    }));
    result.addAll(state.board[1].mapIndexed((index, element) {
      return AnimatedPositioned(
        curve: Curves.linearToEaseOut,
        key: Key("Ring ${element.ring.weight}"),
        left: maxWidth,
        width: maxWidth,
        height: element.height * maxHeight,
        bottom: getBottomPadding(index, maxHeight, state.board[1].toList()),
        child: buildRing(element, maxWidth, maxHeight),
        duration: duration,
      );
    }));
    result.addAll(state.board[2].mapIndexed((index, element) {
      return AnimatedPositioned(
        curve: Curves.linearToEaseOut,
        key: Key("Ring ${element.ring.weight}"),
        left: maxWidth * 2,
        width: maxWidth,
        height: element.height * maxHeight,
        bottom: getBottomPadding(index, maxHeight, state.board[2].toList()),
        child: buildRing(element, maxWidth, maxHeight),
        duration: duration,
      );
    }));
    return result;
  }

  Widget buildRing(RingModel model, double maxWidth, double maxHeight) {
    return Center(
      child: Container(
        width: maxWidth * model.width,
        height: maxHeight * model.height,
        decoration: BoxDecoration(
          color: model.color,
          border: model.selected
              ? Border.all(
                  color: Colors.green,
                  width: 5,
                )
              : null,
          borderRadius: BorderRadius.circular(maxHeight * model.height / 2),
        ),
      ),
    );
  }

  Widget buildSelectable(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                key: firstColumnKey,
                child: GestureDetector(
                  onTap: () {
                    context.read<TowersBoardController>().select(0);
                  },
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                  ),
                ),
              ),
              Expanded(
                key: secondColumnKey,
                child: GestureDetector(
                  onTap: () {
                    context.read<TowersBoardController>().select(1);
                  },
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                  ),
                ),
              ),
              Expanded(
                key: thirdColumnKey,
                child: GestureDetector(
                  onTap: () {
                    context.read<TowersBoardController>().select(2);
                  },
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double getBottomPadding(int index, double maxHeight, List<RingModel> rings) =>
      rings.skip(index + 1).fold<double>(
            0.0,
            (previousValue, element) =>
                previousValue + element.height * maxHeight,
          );
}
