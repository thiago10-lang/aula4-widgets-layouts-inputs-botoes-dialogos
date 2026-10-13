import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercicio_02/main.dart';

void main() {
  testWidgets('Layout em retrato usa o NarrowLayout', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(NarrowLayout), findsOneWidget);
    expect(find.text('Cheetah Coding'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
  });

  testWidgets('Layout em paisagem usa o WideLayout', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(WideLayout), findsOneWidget);
    expect(find.text('C++'), findsOneWidget);
  });
}
