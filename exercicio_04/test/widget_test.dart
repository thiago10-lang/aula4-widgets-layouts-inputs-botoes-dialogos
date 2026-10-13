import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_04/main.dart';

void main() {
  testWidgets('Submit exibe os dados no SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'Thiago');
    await tester.enterText(find.byType(TextFormField).at(1), '11999999999');

    await tester.tap(find.byType(TextFormField).at(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('Name: Thiago'), findsOneWidget);
    expect(find.textContaining('Phone: 11999999999'), findsOneWidget);
  });

  testWidgets('Submit com campos vazios mostra validação', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsNWidgets(3));
    expect(find.byType(SnackBar), findsNothing);
  });
}
