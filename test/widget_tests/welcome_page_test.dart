import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:towers_desktop/screens/game/game_page.dart';
import 'package:towers_desktop/screens/welcome_page.dart';

void main() {
  testGoldens('welcome page test', (tester) async {
    const testKey = Key("test");
    await tester.pumpWidgetBuilder(
      const MaterialApp(
        home: WelcomePage(key: testKey),
      ),
    );
    await screenMatchesGolden(tester, "wtf1");
    expect(find.text("Ханойские башни"), findsOneWidget);

    await tester.tap(find.byKey(WelcomePage.buttonKey));
    await tester.pump();
    await screenMatchesGolden(tester, "wtf");
    expect(find.byKey(GamePage.pageKey), findsOneWidget);
  });
}
