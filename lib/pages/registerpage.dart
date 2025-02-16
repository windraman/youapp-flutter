
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/components/passwordfield.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/pages/aboutpage.dart';
import 'package:youapp/pages/loginpage.dart';

import '../components/youbutton.dart';
import '../components/youtextfield.dart';



import '../services/apiservice.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ReactiveController reactiveController = Get.put(ReactiveController());
  final ApiService apiService = Get.find();
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _register() async {
    // if(formModel.password.toString() == formModel.retype.toString()) {
      final response = await apiService.register();
      if (!mounted) return;

      if(response=="passed"){
        Get.to(() => AboutPage(title: "About"));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
      }
    // }else{
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Password is not the same !")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                          reactiveController.setEmail(value);
                        }
                    ),
                    YouTextField(
                        hint:'Enter Username',
                        keyboardType:  TextInputType.text,
                        onChanged: (value){
                          reactiveController.setUsername(value);
                        }
                    ),
                    PasswordField(hint:'Create Password',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        reactiveController.setPassword(value);
                      },
                      visible: _obscureText,
                      onEyePress: () {
                        _togglePasswordView();
                      } ,
                    ),
                    PasswordField(hint:'Confirm Password',
                      keyboardType:  TextInputType.emailAddress,
                      onChanged: (value){
                        reactiveController.setRetype(value);
                      },
                      visible: _obscureText,
                      onEyePress: () {
                        _togglePasswordView();
                      } ,
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}