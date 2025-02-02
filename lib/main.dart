import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';
import 'package:youapp/pages/registerpage.dart';
import 'package:youapp/services/apiservice.dart';
import 'package:http/http.dart' as http;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ReactiveController reactiveController = Get.put(ReactiveController());
  Get.lazyPut<http.Client>(() => http.Client());
  Get.lazyPut<ApiService>(() => ApiService(
      client:Get.find<http.Client>()
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(title: 'login'),
        '/register': (context) => RegisterPage(title: 'register'),
        '/about': (context) => AboutPage(title: 'about'),
      },
    );
  }
}






