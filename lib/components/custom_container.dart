import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomContainer {
  late double radius;
  late String shape;
  late double depth;
  late Color color;
  late double width;

  // late double height;
  late EdgeInsets margin;
  late EdgeInsets padding;
  late Widget child;
  late Alignment alignment;

  CustomContainer(
      {this.shape = 'flat',
      this.radius = 10,
      this.depth = 4,
      required this.width,
      this.color = Colors.yellow,
      // this.height = 50,
      this.padding = const EdgeInsets.all(0.0),
      this.margin = const EdgeInsets.all(0.0),
      this.child = const Text(""),
      this.alignment = Alignment.centerLeft});

  use() {
    return Container(
        width: width,
        // height: height,
        alignment: alignment,
        child: Neumorphic(
            padding: padding,
            margin: margin,
            style: NeumorphicStyle(
              color: color,
              shape: NeumorphicShape.flat,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
              depth: depth,
            ),
            child: child));
  }
}
