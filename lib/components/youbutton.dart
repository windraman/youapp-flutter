// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouButton extends StatelessWidget {
  final String text;
  final VoidCallback onpress;
  const YouButton({
    super.key,
    required this.text,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xff21485e),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
        ),
        onPressed: onpress,
        child: Text(text),
      ),
    );
  }
}