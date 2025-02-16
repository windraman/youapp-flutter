// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/components/keyvaluefield.dart';

import '../getx/reactive_controller.dart';
import '../models/aboutmodel.dart';

class AboutEdit extends StatelessWidget {
  const AboutEdit({
    super.key,
    required this.aboutModel,
    required this.onPress,
    required this.onToggle,
    required this.onImagePicker
  });

  final AboutModel aboutModel;
  final VoidCallback onPress;
  final VoidCallback onToggle;
  final VoidCallback onImagePicker;

  @override
  Widget build(BuildContext context) {
    ReactiveController reactiveController = Get.put(ReactiveController());
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
                              image: NetworkImage('http://192.168.100.189:3000/${reactiveController.profileImage.value}'),
                              fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: IconButton(
                          onPressed: (){
                            onImagePicker();
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                              shape:
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.transparent)
                                  )
                          ),
                          icon: Icon(
                            size: 30,
                              Icons.add
                          ),

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
              KeyValueField(
                  kunci:"Display Name",
                  value: aboutModel.profile!.name!,
                  type:  'text',
                  enabled: true,
                  onToggle: (){},
                  fontSize: 13,
              ),
              KeyValueField(
                  kunci:"Gender",
                  value: "${reactiveController.selectedGender}",
                  type:  'dropdown',
                  enabled: true,
                  onToggle: (){},
                  fontSize: 12,
              ),
                KeyValueField(
                    kunci:"Birthday",
                    value: "",
                    type:  'date',
                    enabled: true,
                    onToggle: onToggle,
                    fontSize: 13,
                ),
              // KeyValueField(kunci:"Horoscope", value: aboutModel.profile!.horoscope!, type:  'text', enabled: false, onToggle: (){}, fontSize: 12),
              // KeyValueField(kunci:"Zodiac", value: aboutModel.profile!.zodiac!,type: 'text', enabled: false, onToggle: (){}, fontSize: 12),
              KeyValueField(
                  kunci:"Height",
                  value: "${reactiveController.selectedHeight}"
                  ,type:  'height',
                  enabled: true,
                  onToggle: (){},
                  fontSize: 13,
              ),
              KeyValueField(
                  kunci:"Weight",
                  value: "${reactiveController.selectedWeight}",
                  type:  'weight',
                  enabled: true,
                  onToggle: (){},
                  fontSize: 13,
              ),
            ],
          ),
        ),
      ],
    );
  }
}