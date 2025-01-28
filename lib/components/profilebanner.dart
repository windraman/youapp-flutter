import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/aboutmodel.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({
    super.key,
    required this.aboutModel,
  });

  final AboutModel aboutModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wahyu.jpg"), fit: BoxFit.cover),
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
                  "\n\n\n\n\n",
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "@${aboutModel.username!} ( ${calculateAge(DateTime.parse(aboutModel.profile!.birthday!))} )",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            aboutModel.profile!.gender!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

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
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.candlestick_chart),
                          Text(aboutModel.profile!.horoscope!),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0)
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.key),
                          Text(aboutModel.profile!.zodiac!),
                        ],
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
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);
    return years;
  }
}