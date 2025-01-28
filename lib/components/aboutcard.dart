import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/aboutmodel.dart';
import 'keyvaluetext.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
    super.key,
    required this.aboutModel,
    required this.onPress
  });

  final AboutModel aboutModel;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
          child: Row(
            children: [
              Text(
                "About",
                textScaler: TextScaler.linear(1.3),
              ),
              Spacer(),
              IconButton(onPressed: onPress, icon: Icon(Icons.edit))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
          child: Column(
            children: [
              KeyValueText(kunci:"Birthday", value: DateFormat.yMd().format(DateTime.parse(aboutModel.profile!.birthday!)).toString()),
              KeyValueText(kunci:"Horoscope", value: aboutModel.profile!.horoscope!),
              KeyValueText(kunci:"Zodiac", value: aboutModel.profile!.zodiac!),
              KeyValueText(kunci:"Height", value: "${aboutModel.profile!.height!} cm"),
              KeyValueText(kunci:"Weight", value: "${aboutModel.profile!.weight!} kg"),
            ],
          ),
        ),
      ],
    );
  }
}