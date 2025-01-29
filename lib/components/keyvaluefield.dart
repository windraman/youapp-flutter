import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp/components/dropdownselect.dart';
import 'package:youapp/models/aboutmodel.dart';

import '../getx/reactive_controller.dart';

class KeyValueField extends StatelessWidget {
  const KeyValueField({
    super.key,
    required this.kunci,
    required this.value,
    required this.type,
    required this.enabled,
    required this.onToggle,
    required this.fontSize,
  });

  final String kunci;
  final String value;
  final String type;
  final bool enabled;
  final VoidCallback onToggle;
  final double fontSize;


  @override
  Widget build(BuildContext context) {
    ReactiveController reactiveController = Get.put(ReactiveController());
    TextEditingController _controller = TextEditingController(text: value);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "$kunci : ",
            textScaler: TextScaler.linear(0.8),
            style: TextStyle(
                color: Colors.grey
            ),
          ),
        ),
        Spacer(),
        if(type == 'text')
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 35,
              child: TextField(
                onChanged: (value){
                  reactiveController.updateName(value);
                },
                style: TextStyle(
                  fontSize: fontSize
                ),
                textAlign: TextAlign.right,
                controller: _controller,
                enabled: enabled,
                keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.8),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.3),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.3),
                      ),
                    filled: true,
                    fillColor: const Color(0xff1c3c41),
                  )
              ),
            ),
          ),
        ),
        if(type == 'height')
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 35,
                child: TextField(
                    onChanged: (value){
                      reactiveController.updateHeight(int.parse(value));
                    },
                    style: TextStyle(
                        fontSize: fontSize
                    ),
                    textAlign: TextAlign.right,
                    controller: _controller,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.8),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.3),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.3),
                      ),
                      filled: true,
                      fillColor: const Color(0xff1c3c41),
                    )
                ),
              ),
            ),
          ),
        if(type == 'weight')
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 35,
                child: TextField(
                    onChanged: (value){
                      reactiveController.updateWeight(int.parse(value));
                    },
                    style: TextStyle(
                        fontSize: fontSize
                    ),
                    textAlign: TextAlign.right,
                    controller: _controller,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.8),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.3),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.3),
                      ),
                      filled: true,
                      fillColor: const Color(0xff1c3c41),
                    )
                ),
              ),
            ),
          ),
        if(type == 'dropdown')
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Obx (() => DropdownSelect(
                      selectedItem: reactiveController.selectedGender.toString(),
                      items: ["Not Selected", "Male","Female"],
                      onChange: (value){
                        reactiveController.updateGender(value);
                      },
                    )
                  )
              ),
            ),
          ),
        if(type == 'date')
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: onToggle,
                    child:
                    Obx(() => Text(
                        "${reactiveController.selectedBirthday}",
                        textScaler: TextScaler.linear(0.9),
                      )
                  )

                ),
              ),
            ),
          ),

      ],
    );
  }
}