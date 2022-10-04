import 'package:custom_widgets/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatefulWidget {
  final int initialValue;
  final FocusNode? focusNode;
  const TestWidget({super.key, this.initialValue = 1, this.focusNode});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BahagQuantitySelector(
          quantity: quantity,
          unit: 'unit',
          quantityChanged: (newQuantity) {
            setState(() {
              quantity = newQuantity;
            });
          },
          focusNode: widget.focusNode,
        ),
      ),
    );
  }
}

void main() {
  group('quantity selector tests', () {
    final minusButton = find.byKey(const Key('quantity_minus'));
    final plusButton = find.byKey(const Key('quantity_plus'));
    final quntitySelectorTextField = find.byType(TextField);
    final unit = find.text('unit');

    testWidgets('test everything is here', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(minusButton, findsOneWidget);
      expect(plusButton, findsOneWidget);
      expect(quntitySelectorTextField, findsOneWidget);
      expect(unit, findsOneWidget);

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('test increase button', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(find.text('1'), findsOneWidget);

      await tester.tap(plusButton);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('test decrease button', (tester) async {
      await tester.pumpWidget(const TestWidget(
        initialValue: 2,
      ));

      expect(find.text('2'), findsOneWidget);

      await tester.tap(minusButton);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('test decreasing button below one', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(find.text('1'), findsOneWidget);

      await tester.tap(minusButton);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('test increasing button above 9999', (tester) async {
      await tester.pumpWidget(const TestWidget(
        initialValue: 9999,
      ));

      expect(find.text('9999'), findsOneWidget);

      await tester.tap(plusButton);
      await tester.pump();

      expect(find.text('9999'), findsOneWidget);
    });

    testWidgets('test entering number', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(find.text('1'), findsOneWidget);

      await tester.enterText(quntitySelectorTextField, '100');
      await tester.pump();

      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('test entering nothing', (tester) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(TestWidget(focusNode: focusNode));

      expect(find.text('1'), findsOneWidget);
      expect(
          tester.state<_TestWidgetState>(find.byType(TestWidget)).quantity, 1);

      await tester.enterText(quntitySelectorTextField, '');
      await tester.pump();

      expect(find.text(''), findsOneWidget);
      expect(
          tester.state<_TestWidgetState>(find.byType(TestWidget)).quantity, 0);

      focusNode.unfocus();
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(
          tester.state<_TestWidgetState>(find.byType(TestWidget)).quantity, 1);
    });

    testWidgets('test entering to much', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(find.text('1'), findsOneWidget);

      await tester.enterText(quntitySelectorTextField, '10000');
      await tester.pump();

      expect(find.text('1000'), findsOneWidget);
    });

    testWidgets('test entering and button interations', (tester) async {
      await tester.pumpWidget(const TestWidget());

      expect(find.text('1'), findsOneWidget);

      await tester.tap(plusButton);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      await tester.enterText(quntitySelectorTextField, '20');
      await tester.pump();

      expect(find.text('20'), findsOneWidget);

      await tester.tap(minusButton);
      await tester.pump();

      expect(find.text('19'), findsOneWidget);
    });
  });
}
