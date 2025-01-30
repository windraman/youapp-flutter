import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youapp/components/aboutedit.dart';
import 'package:youapp/components/interstcard.dart';
import 'package:youapp/getx/reactive_controller.dart';
import 'package:youapp/models/aboutmodel.dart';
import 'package:youapp/models/basemodel.dart';
import 'package:youapp/models/loginform.dart';
import 'package:youapp/pages/registerpage.dart';

import '../components/aboutcard.dart';
import '../components/keyvaluetext.dart';
import '../components/multiselect.dart';
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
  ReactiveController reactiveController = Get.put(ReactiveController());
  AboutModel aboutModel = AboutModel();
  final ApiService apiService = Get.find();
  bool _isEdit = false;
  var inputFormat = DateFormat('dd/MM/yyyy');

  void _toggleEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  List<String> _selectedItems = [];

  final _picker = ImagePicker();

  // void _loadUsers() async{
  //   var response = await apiService.fetchData("api/users");
  //   aboutModel = AboutModel.fromJson(json.decode(response));
  // }

  void _updateProfile() async{
    Map<String, dynamic>  profile = {};
    if(reactiveController.selectedName.toString()!=""){
      profile["name"] = reactiveController.selectedName.toString();
    } else{
      profile["name"] = aboutModel.profile?.name;
    }
    if(reactiveController.selectedGender.toString()!="Not Selected"){
      profile["gender"] = reactiveController.selectedGender.toString();
    }else{
      profile["gender"] = aboutModel.profile?.gender;
    }
    if(reactiveController.selectedBirthday.toString()!=""){
      profile["birthday"] = reformatDate(reactiveController.selectedBirthday.toString());
    } else{
      profile["birthday"] = aboutModel.profile?.birthday;
    }
    if(reactiveController.selectedHoroscope.toString()!=""){
      profile["horoscope"] = reactiveController.selectedHoroscope.toString();
    } else{
      profile["horoscope"] = aboutModel.profile?.horoscope;
    }
    if(reactiveController.selectedZodiac.toString()!=""){
      profile["zodiac"] = reactiveController.selectedZodiac.toString();
    } else{
      profile["zodiac"] = aboutModel.profile?.zodiac;
    }
    if(reactiveController.selectedHeight.toInt() > 0){
      profile["height"] = reactiveController.selectedHeight.toInt();
    }else{
      profile["height"] = aboutModel.profile?.height;
    }
    if(reactiveController.selectedWeight.toInt()>0){
      profile["weight"] = reactiveController.selectedWeight.toInt();
    }else{
      profile["weight"] = aboutModel.profile?.weight;
    }
    if(reactiveController.selectedInterest.isNotEmpty){
      profile["interests"] = reactiveController.selectedInterest.toList();
    }else{
      profile["interests"] = aboutModel.profile?.interests;
    }
    Map<String, dynamic>  user = {};
    user['profile'] = profile;
    log(profile.toString());
    log(aboutModel.profile!.toJson().toString());

    log((profile.toString()==aboutModel.profile!.toJson().toString()).toString());

    if(profile.toString() == aboutModel.profile!.toJson().toString()){
      log("No change");
    }else{
      // apiService.patch("api/users/profile", user);
    }

    reactiveController.resetAbout();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _loadUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text("${reactiveController.selectedName}"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: apiService.fetchData("api/users"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var jdata = json.decode(snapshot.data.toString());
              aboutModel = AboutModel.fromJson(jdata);
              reactiveController.updateName(aboutModel.profile!.name.toString());
              reactiveController.updateBirthday(inputFormat.format(DateTime.parse(aboutModel.profile!.birthday.toString())).toString());
              reactiveController.updateGender(aboutModel.profile!.gender.toString());
              reactiveController.updateHeight(aboutModel.profile!.height!.toInt());
              reactiveController.updateWeight(aboutModel.profile!.weight!.toInt());
              reactiveController.updateHoroscope(aboutModel.profile!.horoscope.toString());
              reactiveController.updateZodiac(aboutModel.profile!.zodiac.toString());
              reactiveController.updateInterest(aboutModel.profile!.interests!.toList());
              reactiveController.updateProfileImage(jdata["profile"]["image"]);
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
      var birthday = DateTime.parse(aboutModel.profile!.birthday.toString());
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
  XFile? _pickedFile;

  pickImage() async{
     final _pickeFile  = await _picker.pickImage(source: ImageSource.gallery) ;

      if(_pickeFile!=null){
        reactiveController.pickedImage(_pickeFile.path);
        _image = File(reactiveController.pickedImage.value);
        await apiService.updateProfileImage(_image!.path, "api/file-upload/upload", "profile");
        setState(() {

        });
      }
  }
}





