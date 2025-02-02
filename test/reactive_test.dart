import 'dart:ui';

import 'package:get/get_instance/src/lifecycle.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:youapp/getx/reactive_controller.dart';

@GenerateMocks([ReactiveController])

class MockReactive implements ReactiveController{
  @override
  RxString email = "windraman@gmail.com".obs;

  @override
  RxString password= "12345678".obs;

  @override
  RxString pickedImage = "".obs;

  @override
  RxString profileImage = "".obs;

  @override
  RxString retype= "12345678".obs;

  @override
  RxString selectedBirthday = "28/06/80".obs;

  @override
  RxString selectedGender = "Male".obs;

  @override
  RxInt selectedHeight = 175.obs;

  @override
  RxString selectedHoroscope = "Cancer".obs;

  @override
  RxList selectedInterest = ["Sport"].obs;

  @override
  RxString selectedName= "Wahyu Indraman".obs;

  @override
  RxInt selectedWeight = 80.obs;

  @override
  RxString selectedZodiac= "Monkey".obs;

  @override
  RxString token= "Wasdfsrv".obs;

  @override
  RxString username = "windraman".obs;

  @override
  void $configureLifeCycle() {
    // TODO: implement $configureLifeCycle
  }

  @override
  Disposer addListener(GetStateUpdate listener) {
    // TODO: implement addListener
    throw UnimplementedError();
  }

  @override
  Disposer addListenerId(Object? key, GetStateUpdate listener) {
    // TODO: implement addListenerId
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void disposeId(Object id) {
    // TODO: implement disposeId
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  // TODO: implement initialized
  bool get initialized => throw UnimplementedError();

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  // TODO: implement listeners
  int get listeners => throw UnimplementedError();

  @override
  void notifyChildrens() {
    // TODO: implement notifyChildrens
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => throw UnimplementedError();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => throw UnimplementedError();

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  void refreshGroup(Object id) {
    // TODO: implement refreshGroup
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  void removeListenerId(Object id, VoidCallback listener) {
    // TODO: implement removeListenerId
  }

  @override
  void setEmail(String newEmail) {
    // TODO: implement setEmail
  }

  @override
  void setPassword(String newPassword) {
    // TODO: implement setPassword
  }

  @override
  void setRetype(String newRetype) {
    // TODO: implement setRetype
  }

  @override
  void setToken(String newToken) {
    // TODO: implement setToken
  }

  @override
  void setUsername(String newUsername) {
    // TODO: implement setUsername
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
  }

  @override
  void updateBirthday(String newBirthday) {
    // TODO: implement updateBirthday
  }

  @override
  void updateGender(String newGender) {
    // TODO: implement updateGender
  }

  @override
  void updateHeight(int newHeight) {
    // TODO: implement updateHeight
  }

  @override
  void updateHoroscope(String newHoroscope) {
    // TODO: implement updateHoroscope
  }

  @override
  void updateImage(String newImage) {
    // TODO: implement updateImage
  }

  @override
  void updateInterest(List<String> newInterest) {
    // TODO: implement updateInterest
  }

  @override
  void updateName(String newName) {
    // TODO: implement updateName
  }

  @override
  void updateProfileImage(String newImage) {
    // TODO: implement updateProfileImage
  }

  @override
  void updateWeight(int newWeight) {
    // TODO: implement updateWeight
  }

  @override
  void updateZodiac(String newZodiac) {
    // TODO: implement updateZodiac
  }

}