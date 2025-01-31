// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'package:youapp/main.dart';
import 'package:youapp/services/apiservice.dart';

void main() {
  testWidgets('Verify add user button present on ActiveUsers page',
          (WidgetTester tester) async {
        Get.lazyPut<ApiService>(() => ApiService());
        await GetStorage.init();
        //Arrange - Pump MyApp() widget to tester
        await tester.pumpWidget(MyApp());

        //Act - Find button by type
        var fab = find.byType(ElevatedButton);

        //Assert - Check that button widget is present
        expect(fab, findsOneWidget);

      });
}
