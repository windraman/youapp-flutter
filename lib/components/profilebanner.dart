import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx/reactive_controller.dart';
import '../models/aboutmodel.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({
    super.key,
    required this.aboutModel,
  });

  final AboutModel aboutModel;

  @override
  Widget build(BuildContext context) {
    ReactiveController reactiveController = Get.put(ReactiveController());
    var age = "";
    if(aboutModel.profile?.birthday != ""){
      age = calculateAge(DateTime.parse(aboutModel.profile!.birthday!)).toString();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('http://192.168.100.189:3000/${reactiveController.profileImage.value}'),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xff0c1c22),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  "\n\n\n\n",
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              "@${aboutModel.username!} ( $age )",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            reactiveController.selectedGender.value,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if(aboutModel.profile?.horoscope != "")
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0)
                        ),
                          color: Colors.black26
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(Icons.candlestick_chart),
                            Text(aboutModel.profile!.horoscope!),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0)
                        ),
                        color: Colors.black26
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(Icons.key),
                            Text(aboutModel.profile!.zodiac!),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  int calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    return years;
  }
}