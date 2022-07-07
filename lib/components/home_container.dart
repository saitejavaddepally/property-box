// import 'package:flutter/material.dart';

// import '../helper/contants.dart';
// import 'custom_button.dart';

// class HomeContainer extends StatelessWidget {
//   final String text;
//   final Color textColor;
//   final String image;
//   final Color? containerColor;
//   final String buttonText;
//   final Color buttonTextColor;
//   final Color buttonColor;
//   final double buttonWidth;

//   final String text2;
//   final bool isSecondText;
//   final bool isGradient;
//   final LinearGradient? gradient;
//   final void Function() onButtonClick;
//   const HomeContainer(
//       {required this.text,
//       required this.image,
//       required this.buttonText,
//       required this.onButtonClick,
//       this.containerColor,
//       this.text2 = '',
//       this.isSecondText = false,
//       this.textColor = const Color(0xFF1B1B1B),
//       this.buttonWidth = 105,
//       this.buttonTextColor = Colors.white,
//       this.buttonColor = Colors.black,
//       this.isGradient = false,
//       this.gradient,
//       Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: const Color(0xFF202526),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: shadow1,
//       ),
//       child: Container(
//         padding:
//             const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 12),
//         decoration: BoxDecoration(
//           color: isGradient ? null : containerColor,
//           gradient: isGradient ? gradient : null,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(text,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     height: 1.4,
//                     color: Colors.white)),
//             (isSecondText)
//                 ? Column(children: [
//                     const SizedBox(height: 5),
//                     Text(text2,
//                         style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                             height: 1.4)),
//                   ])
//                 : const SizedBox(),
//             const SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(image),
//                 CustomButton(
//                         text: buttonText,
//                         onClick: onButtonClick,
//                         width: buttonWidth,
//                         textColor: buttonTextColor,
//                         height: 40,
//                         color: buttonColor)
//                     .use(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/custom_button.dart';

class HomeContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final String image;
  final Color? containerColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final double buttonWidth;

  final String text2;
  final bool isSecondText;
  final bool isGradient;
  final LinearGradient? gradient;
  final void Function() onButtonClick;
  const HomeContainer(
      {required this.text,
      required this.image,
      required this.buttonText,
      required this.onButtonClick,
      this.containerColor,
      this.text2 = '',
      this.isSecondText = false,
      this.textColor = const Color(0xFF1B1B1B),
      this.buttonWidth = 105,
      this.buttonTextColor = Colors.white,
      this.buttonColor = Colors.black,
      this.isGradient = false,
      this.gradient,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          shape: NeumorphicShape.flat,
          color: const Color(0xFF202526),
          depth: 1.5,
          intensity: 10,
          shadowLightColor: Colors.black,
          lightSource: LightSource.topRight),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isGradient ? null : containerColor,
          gradient: isGradient ? gradient : null,
          borderRadius: BorderRadius.circular(12),
        ),
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    color: Colors.white)),
            (isSecondText)
                ? Column(children: [
                    const SizedBox(height: 5),
                    Text(text2,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.4)),
                  ])
                : const SizedBox(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(image),
                CustomButton(
                        text: buttonText,
                        onClick: onButtonClick,
                        width: buttonWidth,
                        textColor: buttonTextColor,
                        height: 40,
                        color: buttonColor)
                    .use(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
