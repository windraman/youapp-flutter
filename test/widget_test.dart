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
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';
import 'package:youapp/services/apiservice.dart';

void main() {
  testWidgets('Verify Login Page Function',
          (WidgetTester tester) async {
        ApiService apiService = ApiService();
        await tester.pumpWidget(
            GetMaterialApp(
                home:  LoginPage(
                    title: "login",
                  apiService: apiService,
                )
            )
        );

        var fields = find.byType(TextField);
        expect(fields, findsWidgets);

        var button = find.byType(ElevatedButton);
        await tester.tap(button);

        var snackBar = find.byType(ScaffoldMessenger);
        expect(snackBar, findsOneWidget);

      });
}
