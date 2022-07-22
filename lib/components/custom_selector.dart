import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomSelector {
  final List dropDownItems;
  final void Function(dynamic)? onChanged;
  dynamic chosenValue;
  Color? color;
  final Color? dropDownColor;
  late Color textColor;
  late Widget? hint;
  bool? isDense;
  final double borderRadius;

  CustomSelector({
    required this.dropDownItems,
    required this.onChanged,
    required this.chosenValue,
    this.borderRadius = 10,
    this.isDense,
    this.hint,
    this.color,
    this.dropDownColor = const Color(0xFF202526),
    this.textColor = Colors.white,
  });

  use() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
            icon: Icon(Icons.arrow_drop_down, color: HexColor('2AB0E4')),
            dropdownColor: dropDownColor,
            decoration: InputDecoration(
              isDense: isDense,
              fillColor: color,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide.none),
            ),
            items: dropDownItems
                .map((e) => DropdownMenuItem(
                    value: e, child: FittedBox(child: Text("$e"))))
                .toList(),
            validator: (value) => value == null ? 'Field Required' : null,
            hint: hint,
            value: chosenValue,
            isExpanded: true,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
            onChanged: onChanged),
      ),
    );
  }
}
