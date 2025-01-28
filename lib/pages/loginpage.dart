import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youapp/models/aboutmodel.dart';
import 'package:youapp/models/loginform.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/registerpage.dart';

import '../components/youbutton.dart';
import '../components/youtextfield.dart';

import 'package:http/http.dart' as http;

import 'dart:developer';

import '../services/apiservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginformModel formModel = LoginformModel(email: "", password: "");
  ApiService apiService = ApiService();
  final box = GetStorage();

  Future<void> _login() async {
    log(jsonEncode(formModel).toString());

    final response = await apiService.post('api/auth/login', formModel);
    //this is important otherwise navigator wont work
    if (!mounted) return;

    Map<String, dynamic> result = jsonDecode(response.body);
    if(result.containsKey("token")){
      box.write("token", result["token"]);

      final response = await apiService.fetchData("api/users");

      box.write("about", response);

      Navigator.pushNamed(context, '/about');
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
                        setState(() {
                          formModel.email = value;
                        });
                      }
                  ),
                  YouTextField(hint:'Enter Password',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        setState(() {
                          formModel.password = value;
                        });
                      }
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage(title: 'Register')),
                              );
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}