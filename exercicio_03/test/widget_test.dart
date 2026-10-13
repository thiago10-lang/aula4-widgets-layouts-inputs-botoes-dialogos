import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_03/main.dart';

void main() {
  testWidgets('Troca de exemplo ao tocar no botão', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());

    expect(find.text('Container(color: red)'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('button3')));
    await tester.pumpAndSettle();

    expect(find.byType(Example3), findsOneWidget);
  });
}
