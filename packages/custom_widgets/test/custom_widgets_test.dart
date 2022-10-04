import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('bauhaus logo red on white', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BahagTheme.light,
        darkTheme: BahagTheme.dark,
        themeMode: ThemeMode.light,
        home: Container(
          color: Colors.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Konglomerat(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 125,
                      width: 125,
                      child: Konglomerat(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Konglomerat(),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
    await expectLater(find.byType(MaterialApp),
        matchesGoldenFile('goldens/bauhaus_logo_golden_1.png'));
  });
  testWidgets('bauhaus logo red on dark', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BahagTheme.light,
        darkTheme: BahagTheme.dark,
        themeMode: ThemeMode.light,
        home: Container(
          color: const Color.fromARGB(255, 10, 10, 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Konglomerat(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 125,
                      width: 125,
                      child: Konglomerat(),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Konglomerat(),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Konglomerat(),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
    await expectLater(find.byType(MaterialApp),
        matchesGoldenFile('goldens/bauhaus_logo_golden_2.png'));
  });

  testWidgets(
    'KonglomeratSpinner animation sheet',
    (WidgetTester tester) async {
      // Create instance
      final AnimationSheetBuilder animationSheet =
          AnimationSheetBuilder(frameSize: const Size(100, 100));

      const Widget target = Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: KonglomeratSpinner(),
        ),
      );

      // Optional: setup before recording (`recording` is false)
      await tester.pumpWidget(animationSheet.record(
        target,
        recording: false,
      ));
      // Start recording (`recording` is true)
      await tester.pumpFrames(
          animationSheet.record(
            target,
            recording: true,
          ),
          const Duration(seconds: 2));

      // Compare against golden file
      await expectLater(
        animationSheet.collate(800),
        matchesGoldenFile('goldens/konglomeratspinner.animation.png'),
      );
    },
    skip: isBrowser,
  ); // Animation sheet does not support browser https://github.com/flutter/flutter/issues/56001
}
