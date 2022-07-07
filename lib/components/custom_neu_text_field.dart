import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomNeumorphicTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final double borderradius;
  final String? hint;
  final bool? isDense;
  final int? maxLength;
  final TextStyle? style;
  final Color? fillColor;
  const CustomNeumorphicTextField(
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
      this.fillColor = const Color(0xFF202526),
      this.style = const TextStyle(color: Colors.white),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      Neumorphic(
        style: NeumorphicStyle(
            color: const Color(0xFF202526),
            shadowLightColor: Colors.black,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(borderradius))),
        child: TextFormField(
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 9, horizontal: 25),
            hintText: hint,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white.withOpacity(0.3)),
            fillColor: fillColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderradius)),
          ),
        ),
      ),
    ]);
  }
}
