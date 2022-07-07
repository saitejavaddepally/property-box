import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomButton {
  late double radius;
  late String shape;
  late double depth;
  late String text;
  late Color color;
  late Color textColor;
  late double width;
  late double height;
  late Color? shadowColor;
  late Function() onClick;

  late bool rounded;
  late bool isIcon;
  late bool isBorderEnabled;
  late bool isNeu;
  late bool textAlignRight;

  CustomButton({
    required this.text,
    required this.onClick,
    this.shape = 'flat',
    this.radius = 50,
    this.depth = 4,
    this.color = Colors.yellow,
    this.textColor = Colors.white,
    this.width = 150,
    this.height = 50,
    this.rounded = false,
    this.shadowColor,
    this.isIcon = false,
    this.isBorderEnabled = false,
    this.isNeu = true,
    this.textAlignRight = false,
  });

  use() {
    return SizedBox(
        width: width,
        height: height,
        child: Neumorphic(
            style: NeumorphicStyle(
                color: color,
                shape: NeumorphicShape.flat,
                boxShape: (rounded)
                    ? const NeumorphicBoxShape.circle()
                    : NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(radius)),
                depth: (isNeu) ? depth : 0,
                shadowLightColor: shadowColor,
                border: NeumorphicBorder(
                    isEnabled: isBorderEnabled,
                    width: 1.0,
                    color: Colors.blue)),
            child: Container(
              height: double.infinity,
              alignment:
                  (textAlignRight) ? Alignment.centerRight : Alignment.center,
              child: TextButton(
                onPressed: onClick,
                child: (isIcon)
                    ? Image.asset(
                        "assets/$text.png",
                        height: 150,
                        fit: BoxFit.fill,
                      )
                    : Text(
                        text,
                        style: TextStyle(color: textColor),
                      ),
              ),
            )));
  }
}
