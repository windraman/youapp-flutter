import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownSelect extends StatelessWidget{
  const DropdownSelect({
    super.key,
    required this.selectedItem,
    required this.items,
  });

  final String selectedItem;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.bottomRight,
      isExpanded: true,
      style: TextStyle(
        fontSize: 11,
      ),
      value: selectedItem,
      icon: Icon(Icons.arrow_drop_down),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
              item,
            textAlign: TextAlign.right,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
          // selectedItem = newValue!;
      },
    );
  }
}