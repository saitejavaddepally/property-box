import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';

class NeumorphicImageButton extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  const NeumorphicImageButton({required this.image, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
          padding: const EdgeInsets.all(7),
          style: NeumorphicStyle(
              color: CustomColors.dark,
              boxShape: const NeumorphicBoxShape.circle(),
              depth: 7,
              shadowLightColor: Colors.white.withOpacity(0.4),
              shape: NeumorphicShape.flat),
          child: Image.asset(image)),
    );
  }
}
