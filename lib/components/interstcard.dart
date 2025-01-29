
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youapp/components/multiselect.dart';
import 'package:youapp/models/basemodel.dart';

import '../models/aboutmodel.dart';
import 'keyvaluetext.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.interest,
    required this.onPress,
    required this.onMultiselect
  });

  final List<String> interest;
  final VoidCallback onPress;
  final VoidCallback onMultiselect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
          child: Row(
            children: [
              Text(
                "Interest",
                textScaler: TextScaler.linear(1.3),
              ),
              Spacer(),
              IconButton(onPressed: onMultiselect, icon: Icon(Icons.edit))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
          child:  Column(
            children: [
              Wrap(
                children: [
                  if(interest.isNotEmpty)
                    for ( var i in interest )
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                              Radius.circular(25.0)
                          ),
                          color: Colors.blueGrey
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(i.toString()),
                        ),
                      ),
                  if(interest.isEmpty)
                  Text("Add in your interest get a better match.")
                ],
              ),
            ],
          )
        ),
      ],
    );
  }

}