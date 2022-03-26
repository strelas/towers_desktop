import 'package:flutter/material.dart';
import 'package:towers_desktop/screens/game/game_page.dart';

class WelcomePage extends StatelessWidget {
  static const buttonKey = Key("WelcomePage: startGameKey");

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Ханойские башни"),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              key: buttonKey,
              onPressed: () => GamePage.open(context),
              child: const Text("Перейти к игре"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Выполнил\nАнисов Сергей Владимирович\n420-2 группа", textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
