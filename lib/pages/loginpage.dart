
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/components/passwordfield.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/registerpage.dart';
import '../components/youbutton.dart';
import '../components/youtextfield.dart';
import '../services/apiservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ReactiveController reactiveController = Get.put(ReactiveController());
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login() async {
    final ApiService apiService = Get.find();
    final response = await apiService.login();
    if (!mounted) return;

    if(response=="passed"){
      Get.to(() => AboutPage(title: "About"));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xff1c3c41),
                Color(0xff0c1c22),
              ],
              center: Alignment.topRight,
              radius: 1.0,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 0.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Back",
                        textScaler: TextScaler.linear(1.1),
                      ),
                    ]
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(40.0, 50.0, 0.0, 0.0),
                      child: const Text(
                        "Login",
                        textScaler: TextScaler.linear(2.0),
                      )
                  ),
                  YouTextField(
                      hint:'Enter Email',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        reactiveController.setEmail(value);
                      }

                  ),
                  PasswordField(hint:'Enter Password',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        reactiveController.setPassword(value);
                      },
                    visible: _obscureText,
                    onEyePress: () {
                      _togglePasswordView();
                    } ,
                  ),
                  YouButton(text: 'Login',onpress: _login),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No Account ?"),
                        TextButton(
                            onPressed: () {
                              Get.to(RegisterPage(title: "register"));
                            },
                            child: const Text("register here")
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}