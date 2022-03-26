import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towers_desktop/screens/game/board/board.dart';
import 'package:towers_desktop/screens/game/cubit.dart';
import 'package:towers_desktop/screens/game/state.dart';

class GamePage extends StatefulWidget {
  static const counterKey = Key("counterKey");
  static const switchKey = Key("switchKey");

  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameCubit get cubit => context.read();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GamePageState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GamePageStatePreparing) {
          return preparingBody(state);
        }

        if (state is GamePageStateStarted) {
          return startedBody(state);
        }

        return const Scaffold(
          body: Center(
            child: Text("Ошибка состояния"),
          ),
        );
      },
    );
  }

  Widget preparingBody(GamePageStatePreparing state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Выберите количество колец:"),
            const SizedBox(
              height: 10,
            ),
            Counter(
              key: GamePage.counterKey,
              min: 1,
              max: 9,
              initial: state.countOfRings,
              onValueChanged: (value) {
                if (value > state.countOfRings) {
                  cubit.increaseRings();
                } else if (value < state.countOfRings) {
                  cubit.decreaseRings();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () => cubit.onStartGame(),
              child: const Text("Начать игру"),
            ),
          ],
        ),
      ),
    );
  }

  Widget startedBody(GamePageStateStarted state) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Включить автоматические ходы"),
                            Opacity(
                              opacity: state.isAutoMovesEnabled ? 1.0 : 0.4,
                              child: Switch(
                                key: GamePage.switchKey,
                                value: state.isAutoMovesEnabled,
                                onChanged: (value) {
                                  if (state.canStartAutoMoves) {
                                    if (value) {
                                      cubit.enableAutoMoves();
                                    } else {
                                      cubit.disableAutoMoves();
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: Text("Количество ходов: ${state.movesCount}")),
                    ),
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () => cubit.startNewGame(),
                          child: const Text("Начать новую игру"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: Towers()),
            ],
          ),
        ),
      ),
    );
  }
}
