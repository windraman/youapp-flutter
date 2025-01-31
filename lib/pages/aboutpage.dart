import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youapp/components/aboutedit.dart';
import 'package:youapp/components/interstcard.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/models/aboutmodel.dart';

import '../components/aboutcard.dart';
import '../components/multiselect.dart';
import '../components/profilebanner.dart';


import 'dart:developer';


import '../services/apiservice.dart';

import 'package:intl/intl.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
    required this.title,
    required this.apiService
  });

  final String title;
  final ApiService apiService;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  ReactiveController reactiveController = Get.put(ReactiveController());
  AboutModel aboutModel = AboutModel();

  bool _isEdit = false;
  var inputFormat = DateFormat('dd/MM/yyyy');

  void _toggleEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  List<String> _selectedItems = [];

  final _picker = ImagePicker();

  void _updateProfile() async{
    Map<String, dynamic>  profile = {};
    profile["name"] = reactiveController.selectedName.toString();
    profile["gender"] = reactiveController.selectedGender.toString();
    profile["birthday"] = reformatDate(reactiveController.selectedBirthday.toString());
    profile["horoscope"] = reactiveController.selectedHoroscope.toString();
    profile["zodiac"] = reactiveController.selectedZodiac.toString();
    profile["height"] = reactiveController.selectedHeight.toInt();
    profile["weight"] = reactiveController.selectedWeight.toInt();
    profile["interests"] = reactiveController.selectedInterest.toList();
    profile["image"] = aboutModel.profile?.image;

    Map<String, dynamic>  user = {};
    user['profile'] = profile;
    log(profile.toString());
    log(aboutModel.profile!.toJson().toString());

    log((profile.toString()==aboutModel.profile!.toJson().toString()).toString());

    if(profile.toString() == aboutModel.profile!.toJson().toString()){
      log("No change");
    }else{
      widget.apiService.patch("api/users/profile", user);
    }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${reactiveController.selectedName}"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: widget.apiService.fetchData("api/users"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var jdata = json.decode(snapshot.data.toString());
              aboutModel = AboutModel.fromJson(jdata);
              reactiveController.updateName(aboutModel.profile!.name.toString());
              if(aboutModel.profile?.birthday!="") {
                reactiveController.updateBirthday(inputFormat.format(
                    DateTime.parse(aboutModel.profile!.birthday.toString()))
                    .toString());
              }
              reactiveController.updateGender(aboutModel.profile!.gender.toString());
              reactiveController.updateHeight(aboutModel.profile!.height!.toInt());
              reactiveController.updateWeight(aboutModel.profile!.weight!.toInt());
              reactiveController.updateHoroscope(aboutModel.profile!.horoscope.toString());
              reactiveController.updateZodiac(aboutModel.profile!.zodiac.toString());
              reactiveController.updateInterest(aboutModel.profile!.interests!.toList());
              if(aboutModel.profile!.image != "") {
                reactiveController.updateProfileImage(jdata["profile"]["image"]);
              }else{
                reactiveController.updateProfileImage(" ");
              }
              _selectedItems = aboutModel.profile!.interests!.toList();
              return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff09141a),
                  ),
                  child: Column(
                    children: [
                      ProfileBanner(aboutModel: aboutModel),
                      if(aboutModel.profile != null)
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
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 30.0, 10.0, 0.0),
                              child: Column(
                                children: [
                                  if(!_isEdit)
                                    AboutCard(aboutModel: aboutModel, onPress: () {
                                      _toggleEdit();
                                    }),
                                  if(_isEdit)
                                    AboutEdit(
                                      aboutModel: aboutModel,
                                      onPress: () {
                                        _updateProfile();
                                        _toggleEdit();
                                      },
                                      onToggle: () {
                                        _showDatePicker(context);
                                      },
                                      onImagePicker: () {
                                        pickImage();
                                      },
                                    ),
                                ],
                              ),

                            ),
                          ],
                        ),
                      if(aboutModel.profile != null)
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
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 30.0, 10.0, 0.0),
                              child: Column(
                                children: [
                                    InterestCard(
                                        interest: _selectedItems,
                                        onPress: () {},
                                        onMultiselect: (){
                                          _showMultiSelect();
                                        },
                                    )
                                ],
                              ),

                            ),
                          ],
                        ),
                    ],
                  )
              );
            } else {
              return Center(child: const Text("Error fething data !"));
            }
          }
        ),
      )
    );
  }

  String reformatDate(String date){
    var split = date.split("/");
    return "${split[2]}-${split[1]}-${split[0]}";
  }

  // Function to show Cupertino Date Picker
  void _showDatePicker(BuildContext context) {
    DateTime initDate = DateTime.now();
    if(aboutModel.profile?.birthday != ""){
      initDate = DateTime.parse(aboutModel.profile!.birthday.toString());
      DateTime.parse(aboutModel.profile!.birthday.toString());
    }
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
                    initialDateTime: initDate,
                    minimumDate: DateTime.parse("1965-01-01"),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                        reactiveController.updateBirthday(inputFormat.format(dateTime).toString());
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Music',
      'Animation',
      'Programming',
      'Sport',
      'Docker',
      'MySQL'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
            items: items,
            // ignore: invalid_use_of_protected_member
            currentSelected: reactiveController.selectedInterest.value as List<String>
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      // reactiveController.updateInterest(results);
      _updateProfile();
    }
  }

  File? _image;

  pickImage() async{
     final _pickeFile  = await _picker.pickImage(source: ImageSource.gallery) ;

      if(_pickeFile!=null){
        reactiveController.pickedImage(_pickeFile.path);
        _image = File(reactiveController.pickedImage.value);
        await widget.apiService.updateProfileImage(_image!.path, "api/file-upload/upload", "profile");
        setState(() {

        });
      }
  }
}





