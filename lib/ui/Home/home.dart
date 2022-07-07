import 'package:flutter/material.dart';

import '../../components/custom_neumorphic_button.dart';
import '../../components/home_container.dart';
import '../../helper/contants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202526),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      CustomImage(
                        image: "assets/profile.png",
                        text: "Kumar",
                        onTap: () {},
                      ),
                    ]),
                    Row(
                      children: [
                        CustomImage(
                            image: "assets/explorer.png",
                            text: "explore",
                            onTap: () {}),
                        const SizedBox(width: 15),
                        CustomImage(
                            image: "assets/alerts.png",
                            text: "alerts",
                            onTap: () {}),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                        children: [
                      TextSpan(text: "Hello, "),
                      TextSpan(
                          text: "Name",
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ])),
                const SizedBox(height: 5),
                const Text('Todays recommended actions for you',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white)),
                // Container(
                //   padding: const EdgeInsets.only(
                //       top: 20, right: 20, left: 20, bottom: 12),
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(colors: [
                //       const Color(0xFF11073E),
                //       const Color(0xFF53439B).withOpacity(0.40)
                //     ]),
                //     borderRadius: BorderRadius.circular(12),
                //     boxShadow: const [
                //       BoxShadow(
                //           offset: Offset(-6, -6),
                //           spreadRadius: 0,
                //           color: Color(0xFF113B5F),
                //           blurRadius: 12)
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Digitalize your property',
                //           style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.white.withOpacity(0.87))),
                //       const SizedBox(height: 5),
                //       Text(
                //           'Don’t carry property docs to demonstrate, just digitalize',
                //           style: TextStyle(
                //               fontSize: 14,
                //               height: 1.4,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.white.withOpacity(0.87))),
                //       const SizedBox(height: 5),
                //       Text('One free digitalization.',
                //           style: TextStyle(
                //               fontSize: 14,
                //               height: 1.4,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.white.withOpacity(0.7))),
                //       const SizedBox(height: 15),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Image.asset("assets/digital.png"),
                //           CustomButton(
                //                   text: 'Go Digital',
                //                   onClick: () {},
                //                   color: Color(0xFFF3F4F6),
                //                   textColor: Color(0xFF21293A),
                //                   width: 109)
                //               .use(),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Buy verified properties",
                    isSecondText: true,
                    text2:
                        'Serach your dream property, chat and close the deal.',
                    image: "assets/find.png",
                    isGradient: true,
                    gradient: LinearGradient(colors: [
                      const Color(0xFF0B4B51),
                      const Color(0xFFF0AF63).withOpacity(0.80)
                    ]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 137,
                    buttonText: "Find Properties",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Hire property box authorized agent",
                    isSecondText: true,
                    text2:
                        'Our agent will work with you to get best property and close the deal.',
                    image: "assets/hire.png",
                    isGradient: true,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF461B59), Color(0xFFDE5670)]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 102,
                    buttonText: "Hire Now",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Which property you can attend",
                    isSecondText: true,
                    text2:
                        'Check our property buying score to know your buying range.',
                    image: "assets/score.png",
                    isGradient: true,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF27465E), Color(0xFF38C6CA)]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 107,
                    buttonText: "Get Score",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
                const SizedBox(height: 30),
                HomeContainer(
                    text: "Refer your friends",
                    isSecondText: true,
                    text2: 'Win discount on our services by refering',
                    image: "assets/refer.png",
                    isGradient: true,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF076521), Color(0xFFB3CD4B)]),
                    textColor: Colors.white.withOpacity(0.87),
                    buttonWidth: 109,
                    buttonText: "Refer Now",
                    buttonTextColor: const Color(0xFF21293A),
                    buttonColor: const Color(0xFFF3F4F6),
                    onButtonClick: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String image;
  final String text;
  final bool isDecorated;
  final int? counter;
  final bool isCounter;

  final void Function()? onTap;

  const CustomImage(
      {required this.image,
      required this.text,
      this.onTap,
      this.isDecorated = false,
      this.counter,
      this.isCounter = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Column(children: [
          Container(
              height: 40,
              width: 40,
              decoration: (isDecorated)
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue))
                  : const BoxDecoration(boxShadow: shadow1),
              child: Stack(children: [
                Image.asset(image, height: 40, width: 40),
                if (isCounter && counter != 0)
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          height: 20,
                          width: 19,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Center(child: Text(counter.toString()))))
              ])),
          const SizedBox(height: 3),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.white,
                letterSpacing: -0.15),
          ),
        ]),
      ),
    );
  }
}
