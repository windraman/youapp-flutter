
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouTextField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const YouTextField({
    super.key,
    required this.hint,
    required this.keyboardType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          filled: true,
          fillColor: const Color(0xff1c3c41),
          hintText: hint,
        ),
      ),
    );
  }
}