import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';
import 'package:youapp/pages/registerpage.dart';
import 'package:youapp/services/apiservice.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ApiService>(() => ApiService());
  // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = Get.find();
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
        '/': (context) => LoginPage(title: 'login', apiService: apiService),
        '/register': (context) => RegisterPage(title: 'register', apiService: apiService),
        '/about': (context) => AboutPage(title: 'about', apiService: apiService),
      },
    );
  }
}






