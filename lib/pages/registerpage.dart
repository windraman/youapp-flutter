import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youapp/models/loginform.dart';
import 'package:youapp/models/registerform.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';

import '../components/youbutton.dart';
import '../components/youtextfield.dart';

import 'package:http/http.dart' as http;

import 'dart:developer';

import '../services/apiservice.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterformModel formModel = RegisterformModel(email: "",username: "", password: "");
  ApiService apiService = ApiService();
  final box = GetStorage();
  Future<void> _register() async {
    log(jsonEncode(formModel).toString());
    final response = await apiService.post('api/auth/register', formModel);
    Map<String, dynamic> result = jsonDecode(response.body);
    if(result.containsKey("token")){
      box.write("token", result["token"]);
      Get.to(AboutPage(title: "About"));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(widget.title),
      // ),
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
                  onTap: () {},
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
                        "Register",
                        textScaler: TextScaler.linear(2.0),
                      )
                  ),
                  YouTextField(
                      hint:'Enter Email',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        setState(() {
                          formModel.email = value;
                        });
                      }
                  ),
                  YouTextField(
                      hint:'Enter Username',
                      keyboardType:  TextInputType.text,
                      onChanged: (value){
                        setState(() {
                          formModel.username = value;
                        });
                      }
                  ),
                  YouTextField(hint:'Create Password',
                      keyboardType:  TextInputType.visiblePassword,
                      onChanged: (value){
                        setState(() {
                          formModel.password = value;
                        });
                      }
                  ),
                  YouTextField(hint:'Confirm Password',
                      keyboardType:  TextInputType.visiblePassword,
                      onChanged: (value){
                        setState(() {
                          formModel.password = value;
                        });
                      }
                  ),
                  YouButton(text: 'Register',onpress: _register),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an Account?"),
                        TextButton(
                            onPressed: () {
                              Get.to(LoginPage(title: "login"));
                            },
                            child: const Text("Login here")
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}