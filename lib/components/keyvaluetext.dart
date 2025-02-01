// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyValueText extends StatelessWidget {
  const KeyValueText({
    super.key,
    required this.kunci,
    required this.value
  });

  final String kunci;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: [
          Text(
            "$kunci : ",
            textScaler: TextScaler.linear(0.9),
            style: TextStyle(
                color: Colors.grey
            ),
          ),
          Text(
            value,
            textScaler: TextScaler.linear(0.95),
            style: TextStyle(
                color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}