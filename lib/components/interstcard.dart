import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/aboutmodel.dart';
import 'keyvaluetext.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.aboutModel,
    required this.onPress
  });

  final AboutModel aboutModel;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    List<String> interest = aboutModel.profile!.interests!;
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
              IconButton(onPressed: onPress, icon: Icon(Icons.edit))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 20.0),
          child:  Row(
            children: [
              if(interest.isNotEmpty)
                for ( var i in interest )
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0)
                      ),

                    ),
                    child: Text(i.toString()),
                  ),
              if(interest.isEmpty)
              Text("Add in your interest get a better match.")
            ],
          )
        ),
      ],
    );
  }
}