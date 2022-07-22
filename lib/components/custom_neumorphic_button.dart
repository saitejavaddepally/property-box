import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomNeumorphicButtom extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color shadowColor;
  final double borderRadius;
  final Color? textColor;
  const CustomNeumorphicButtom(
      {required this.buttonText,
      required this.buttonColor,
      required this.shadowColor,
      this.textColor,
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
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: textColor),
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
