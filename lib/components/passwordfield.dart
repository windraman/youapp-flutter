
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool visible;
  final VoidCallback onEyePress;

  const PasswordField({
    super.key,
    required this.hint,
    required this.keyboardType,
    required this.onChanged,
    required this.visible,
    required this.onEyePress
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: TextField(
        onChanged: onChanged,
        obscureText: visible,
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
            suffixIcon: IconButton(
              icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
              onPressed: onEyePress,
            )
        ),
      ),
    );
  }
}