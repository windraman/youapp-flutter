import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youapp/components/aboutedit.dart';
import 'package:youapp/components/interstcard.dart';
import 'package:youapp/models/aboutmodel.dart';
import 'package:youapp/models/loginform.dart';
import 'package:youapp/pages/registerpage.dart';

import '../components/aboutcard.dart';
import '../components/keyvaluetext.dart';
import '../components/profilebanner.dart';
import '../components/youbutton.dart';
import '../components/youtextfield.dart';

import 'package:http/http.dart' as http;

import 'dart:developer';

import 'package:flutter/services.dart' show rootBundle;

import '../services/apiservice.dart';

import 'package:intl/intl.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final box = GetStorage();
  AboutModel aboutModel = AboutModel();
  ApiService apiService = ApiService();
  bool _isEdit = false;
  DateTime _selectedDate = DateTime.now();

  void _toggleEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  @override
  void initState() {
    super.initState();
    aboutModel = AboutModel.fromJson(json.decode(box.read('about')));

  }


  Future<void> _loadProfile() async {
    final response = await apiService.fetchData("api/users");

    aboutModel = AboutModel.fromJson(json.decode(response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("@${aboutModel.username.toString()}"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list))
        ],
      ),
      body: SingleChildScrollView(

        child: Container(
            decoration: const BoxDecoration(
              color:Color(0xff09141a) ,
            ),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 0.0),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           Navigator.pop(context);
                //         },
                //         child: const Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Icon(Icons.arrow_back_ios),
                //               Text(
                //                 "Back",
                //                 textScaler: TextScaler.linear(1.1),
                //               ),
                //             ]
                //         ),
                //       ),
                //       Spacer(),
                //       Text("@${aboutModel.username.toString()}"),
                //       Spacer(),
                //       Icon(Icons.menu),
                //     ],
                //   ),
                // ),
                ProfileBanner(aboutModel: aboutModel),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black26,
                                Colors.black87,
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                        ),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Column(
                          children: [
                            if(_isEdit)
                              AboutCard(aboutModel: aboutModel, onPress: () {
                                _toggleEdit();
                              }),
                            if(!_isEdit)
                            AboutEdit(
                                aboutModel: aboutModel,
                                onPress: () {
                                  _toggleEdit();
                                },
                                onToggle: (){
                                  _showDatePicker(context);
                                }
                            ),
                          ],
                        ),

                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black26,
                              Colors.black87,
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey,
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                      child: Column(
                        children: [
                          InterestCard(aboutModel: aboutModel, onPress: (){})
                        ],
                      ),

                    ),
                  ],
                ),

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

  // Function to show Cupertino Date Picker
  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) =>
          Container(
            height: 350,
            color: Colors.black26,
            child: Column(
              children: [
                // Done button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.black87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                        child: Text("Done"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                // Date Picker
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: _selectedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      setState(() {
                        aboutModel.profile?.birthday = dateTime as String?;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}





