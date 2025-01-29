import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youapp/pages/registerpage.dart';
import 'package:youapp/services/apiservice.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ApiService>(() => ApiService());
  await GetStorage.init();
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
      // home: const LoginPage(
      //     title: 'YouApp'
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(title: 'login'),
        '/register': (context) => const RegisterPage(title: 'register'),
        '/about': (context) => const AboutPage(title: 'about'),
      },
    );
  }
}






