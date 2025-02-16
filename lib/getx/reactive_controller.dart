
import 'package:get/get.dart';
// ignore: unused_import
import 'package:youapp/models/aboutmodel.dart';

class ReactiveController extends GetxController{
  var email = ''.obs;

  void setEmail(String newEmail){
    email.value = newEmail;
  }

  var username = ''.obs;

  void setUsername(String newUsername){
    username.value = newUsername;
  }

  var password = ''.obs;

  void setPassword(String newPassword){
    password.value = newPassword;
  }

  var retype = ''.obs;

  void setRetype(String newRetype){
    retype.value = newRetype;
  }

  var token = ''.obs;

  void setToken(String newToken){
    token.value = newToken;
  }

  var selectedBirthday = "".obs;

  void updateBirthday(String newBirthday){
    selectedBirthday.value = newBirthday;
  }

  var selectedName = "".obs;

  void updateName(String newName){
    selectedName.value = newName;
  }

  var selectedGender = "Not Selected".obs;

  void updateGender(String newGender){
    selectedGender.value = newGender;
  }

  var selectedHeight = 0.obs;

  void updateHeight(int newHeight){
    selectedHeight.value = newHeight;
  }

  var selectedWeight = 0.obs;

  void updateWeight(int newWeight){
    selectedWeight.value = newWeight;
  }

  var selectedHoroscope = "".obs;

  void updateHoroscope(String newHoroscope){
    selectedHoroscope.value = newHoroscope;
  }

  var selectedZodiac = "".obs;

  void updateZodiac(String newZodiac){
    selectedZodiac.value = newZodiac;
  }

  var profileImage = "".obs;

  void updateProfileImage(String newImage){
    profileImage.value = newImage;
  }

  var selectedInterest= [].obs;

  void updateInterest(List<String> newInterest){
    selectedInterest.value = newInterest;
  }


  var pickedImage = "".obs;

  void updateImage(String newImage){
    pickedImage.value = newImage;
  }

}