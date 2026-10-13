import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_05/main.dart';

void main() {
  testWidgets('Seleciona abas da BottomAppBar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('TAB: 0'), findsOneWidget);

    await tester.tap(find.text('Bar'));
    await tester.pump();

    expect(find.text('TAB: 3'), findsOneWidget);
  });

  testWidgets('FAB exibe novas opções', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.mail), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.sms), findsOneWidget);
    expect(find.byIcon(Icons.mail), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);

    await tester.tap(find.byIcon(Icons.mail));
    await tester.pumpAndSettle();

    expect(find.text('FAB: 1'), findsOneWidget);
    expect(find.byIcon(Icons.mail), findsNothing);
  });
}
