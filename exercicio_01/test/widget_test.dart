import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_01/main.dart';

void main() {
  testWidgets('Exibe o GridView com duas colunas e legendas', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('Chennai'), findsWidgets);
    expect(find.text('Flower Market'), findsOneWidget);
  });
}
