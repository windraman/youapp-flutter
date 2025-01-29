import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youapp/models/aboutmodel.dart';

class ReactiveController extends GetxController{
  var token = ''.obs;

  void setToken(String newToken){
    token.value = newToken;
  }

  var changedAbout = false.obs;
  var selectedBirthday = "".obs;

  void updateBirthday(String newBirthday){
    selectedBirthday.value = newBirthday;
  }

  var selectedName = "".obs;

  void updateName(String newName){
    selectedName.value = newName;
    changedAbout.value = true;
  }

  var selectedGender = "Not Selected".obs;

  void updateGender(String newGender){
    selectedGender.value = newGender;
    changedAbout.value = true;
  }

  var selectedHeight = 0.obs;

  void updateHeight(int newHeight){
    selectedHeight.value = newHeight;
    changedAbout.value = true;
  }

  var selectedWeight = 0.obs;

  void updateWeight(int newWeight){
    selectedWeight.value = newWeight;
    changedAbout.value = true;
  }

  var selectedHoroscope = "".obs;

  void updateHoroscope(String newHoroscope){
    selectedHoroscope.value = newHoroscope;
  }

  var selectedZodiac = "".obs;

  void updateZodiac(String newZodiac){
    selectedZodiac.value = newZodiac;
  }

  var selectedInterest= [].obs;

  void updateInterest(List<String> newInterest){
    selectedInterest.value = newInterest;
    changedAbout.value = true;
  }

  void resetAbout(){
    selectedName.value = "";
    selectedBirthday.value = "";
    selectedGender.value = "Not Selected";
    selectedHeight.value = 0;
    selectedWeight.value = 0;
    selectedInterest.value = [];
    changedAbout.value = false;
  }

}