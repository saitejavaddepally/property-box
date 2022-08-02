import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';

class CustomNeumorphicIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final double padding;
  final void Function()? onTap;
  const CustomNeumorphicIcon(
      {required this.icon,
      this.iconSize = 28,
      this.padding = 10,
      this.iconColor,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        padding: EdgeInsets.all(padding),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: const NeumorphicBoxShape.circle(),
            color: CustomColors.dark,
            depth: 4,
            intensity: 0.8,
            shadowLightColor: Colors.white.withOpacity(0.5)),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
