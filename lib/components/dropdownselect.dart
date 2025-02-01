// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DropdownSelect extends StatelessWidget{
  const DropdownSelect({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChange,
  });

  final String selectedItem;
  final List<String> items;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white12, // Background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      alignment: Alignment.centerRight,
      isExpanded: true,
      style: TextStyle(
        fontSize: 13,
      ),
      value: selectedItem,
      icon: Icon(Icons.arrow_drop_down),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
              item,
            textAlign: TextAlign.end,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChange(newValue!);
      },
    );
  }
}