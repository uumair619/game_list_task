// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_list_task/main.dart';
import 'package:game_list_task/src/App.dart';
import 'package:game_list_task/src/database/DatabaseHelper.dart';
import 'package:game_list_task/src/di/Injector.dart';
import 'package:get_it/get_it.dart';

void main() {
  testWidgets('Empty Game List Test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    Injector.initGetIt();
    await tester.pumpWidget( App());
    await tester.pump();
    expect(find.byKey(Key("no_item")), findsOneWidget);
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
