import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_06/main.dart';

void main() {
  testWidgets('FAB exibe o AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Você está no App de Notas de Tarefas'), findsOneWidget);
  });

  testWidgets('Marcar tarefa a move para concluídas', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('You have 5 uncompleted tasks'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(5));

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();

    expect(find.text('You have 4 uncompleted tasks'), findsOneWidget);

    await tester.tap(find.text('View Completed Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Completed Tasks'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });
}
