import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youapp/components/keyvaluefield.dart';

import '../models/aboutmodel.dart';
import 'keyvaluetext.dart';

class AboutEdit extends StatelessWidget {
  const AboutEdit({
    super.key,
    required this.aboutModel,
    required this.onPress,
    required this.onToggle
  });

  final AboutModel aboutModel;
  final VoidCallback onPress;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    var inputFormat = DateFormat('dd/MM/yyyy');
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
              TextButton(
                onPressed: (){
                  //update api
                  onPress();
                },
                child: Text(
                    "save & update",
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/wahyu.jpg"), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Add Image"),
                    )
                  ],
                ),
              ),
              KeyValueField(kunci:"Display Name", value: aboutModel.profile!.name!,type:  'text', enabled: true, onToggle: (){}, fontSize: 12),
              KeyValueField(kunci:"Gender", value: aboutModel.profile!.gender!,type:  'dropdown', enabled: true, onToggle: (){}, fontSize: 12),
              KeyValueField(kunci:"Birthday", value: DateFormat.yMd().format(DateTime.parse(aboutModel.profile!.birthday!)).toString(),type:  'date', enabled: true, onToggle: onToggle, fontSize: 12),

              KeyValueField(kunci:"Horoscope", value: aboutModel.profile!.horoscope!, type:  'text', enabled: false, onToggle: (){}, fontSize: 12),
              KeyValueField(kunci:"Zodiac", value: aboutModel.profile!.zodiac!,type: 'text', enabled: false, onToggle: (){}, fontSize: 12),
              KeyValueField(kunci:"Height", value: "${aboutModel.profile!.height!}",type:  'number', enabled: true, onToggle: (){}, fontSize: 12),
              KeyValueField(kunci:"Weight", value: "${aboutModel.profile!.weight!}",type:  'number', enabled: true, onToggle: (){}, fontSize: 12),
            ],
          ),
        ),
      ],
    );
  }
}