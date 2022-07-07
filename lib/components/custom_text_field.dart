import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final EdgeInsets contentPadding;
  final double borderradius;
  final String? hint;
  final bool? isDense;
  final int? maxLength;
  final TextStyle? style;
  const CustomTextField(
      {this.validator,
      this.onChanged,
      this.controller,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.borderradius = 10,
      this.icon,
      this.hint,
      this.isDense,
      this.maxLength,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      this.style,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: style,
      cursorColor: Colors.white.withOpacity(0.1),
      decoration: InputDecoration(
        isDense: isDense,
        suffixIcon: icon,
        counterText: '',
        contentPadding: contentPadding,
        hintText: hint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white.withOpacity(0.3)),
        fillColor: Colors.white.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderradius)),
      ),
    );
  }
}
