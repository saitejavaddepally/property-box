import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircularNeumorphicButton {
  late Color color;
  late bool isTextUnder;
  late String text;
  late String imageName;
  late GestureTapCallback onTap;
  late double size;
  late bool isNeu;
  late double width;
  late double padding;

  CircularNeumorphicButton(
      {this.isTextUnder = false,
      this.color = Colors.white,
      this.text = '',
      required this.imageName,
      required this.onTap,
      this.size = 40,
      this.isNeu = true,
      this.padding = 0,
      this.width = 10});

  use() {
    return Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                    color: color,
                    shape: NeumorphicShape.flat,
                    boxShape: const NeumorphicBoxShape.circle(),
                    depth: (isNeu) ? 4 : 0,
                    intensity: (isNeu) ? 0.8 : 0,
                    shadowLightColor: Colors.white.withOpacity(0.5)),
                child: Container(
                  padding: EdgeInsets.all(padding),
                  width: size,
                  height: size,
                  // margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/$imageName.png",
                  ),
                ),
              ),
              const SizedBox(height: 5),
              (isTextUnder)
                  ? Center(
                      child: Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: -0.15,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    )
                  : const Text('')
            ],
          ),
        ));
  }
}
