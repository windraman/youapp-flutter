// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:youapp/components/aboutcard.dart';
import 'package:youapp/components/keyvaluetext.dart';
import 'package:youapp/components/profilebanner.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/models/aboutmodel.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';

import 'package:youapp/services/apiservice.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';
import 'reactive_test.dart';
import 'reactive_test.mocks.dart';


void main() {
  late ApiService apiService;
  late MockClient mockHttpClient;
  late ReactiveController reactiveController;

  setUp(() {
    mockHttpClient = MockClient();
    apiService = ApiService(client: mockHttpClient);
    Get.lazyPut(()=>apiService);
    reactiveController = MockReactive();
  });

  testWidgets('Login Page Testing', (WidgetTester tester) async {
    when(mockHttpClient.post(
      any,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer(
          (_) async => http.Response('{"token": "9999999"}', 200),
    );


    await tester.pumpWidget(
        GetMaterialApp(
            home:  LoginPage(
                title: "login"
            )
        )
    );

    var fields = find.byType(TextField);
    expect(fields, findsWidgets);

    var button = find.byType(ElevatedButton);
    expect(button, findsWidgets);

    await tester.tap(button);

    var snackBar = find.byType(ScaffoldMessenger);
    expect(snackBar, findsOneWidget);

  });

  testWidgets('About Page testing', (WidgetTester tester) async {

    AboutModel aboutModel = AboutModel(
      sId: "32121",
      email: "windraman@gmail.com",
      username: "windraman",
      createdAt: "",
      updatedAt: "",
      profile: Profile(
        name: "Wahyu"
      )
    );
    when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(
      jsonEncode(aboutModel),
      200,
      headers: {"Content-Type": "application/json"},
    ));


    await tester.pumpWidget(
        GetMaterialApp(
            home:  AboutPage(
                title: "about"
            )
        )
    );



    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    expect(find.byType(FutureBuilder<String>), findsOneWidget);

    await tester.pumpWidget(GetMaterialApp(
        home:  AboutPage(
            title: "about"
        )
    ));

    reactiveController = MockReactive();


    expect(find.byType(Container), findsOneWidget);

    var iconButtons = find.byType(IconButton);
    expect(iconButtons, findsOneWidget);


  });
}
