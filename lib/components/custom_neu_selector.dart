import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomNeuSelector {
  final List dropDownItems;
  final void Function(dynamic)? onChanged;
  dynamic chosenValue;
  late Color color;
  late Color textColor;
  late Widget? hint;
  bool? isDense;
  bool isPrefixIcon;
  Widget? prefixIcon;
  final double borderRadius;

  CustomNeuSelector({
    required this.dropDownItems,
    required this.onChanged,
    required this.chosenValue,
    this.borderRadius = 31,
    this.isDense,
    this.hint,
    this.color = const Color(0xFF213C53),
    this.textColor = Colors.white,
    this.isPrefixIcon = false,
    this.prefixIcon,
  });

  use() {
    return Neumorphic(
      style: NeumorphicStyle(
          color: color,
          shape: NeumorphicShape.flat,
          shadowLightColor: Colors.white.withOpacity(0.5),
          depth: 10,
          intensity: 0.5,
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(borderRadius))),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
              icon: (isPrefixIcon)
                  ? const SizedBox()
                  : const Icon(Icons.arrow_drop_down),
              iconEnabledColor: const Color(0xFF2AB0E4),
              iconDisabledColor: const Color(0xFF2AB0E4),
              dropdownColor: color,
              decoration: InputDecoration(
                isDense: isDense,
                fillColor: color,
                filled: true,
                prefixIcon: (isPrefixIcon) ? prefixIcon : null,
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
      ),
    );
  }
}
