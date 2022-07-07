import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomNeumorphicButtom extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color shadowColor;
  final double borderRadius;
  const CustomNeumorphicButtom(
      {required this.buttonText,
      required this.buttonColor,
      required this.shadowColor,
      this.borderRadius = 10,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onTap,
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF202526)),
        ),
      ),
      style: NeumorphicStyle(
          color: buttonColor,
          shadowLightColor: shadowColor,
          boxShape:
              NeumorphicBoxShape.roundRect(BorderRadius.circular(borderRadius)),
          shape: NeumorphicShape.flat),
    );
  }
}
