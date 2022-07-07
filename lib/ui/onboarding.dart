import 'package:flutter/material.dart';
import 'package:property_box/route_generator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Widget> list = [
    const Page(
      image: "assets/onboarding1.png",
      text1: "Buy verified properties",
      text2: "Explore, chat and buy properties directly from verified agents",
    ),
    const Page(
      image: "assets/onboarding2.png",
      text1: "AI enebaled property screen",
      text2: "Search properties, near by locations by google advanced maps API",
    ),
    const Page(
      image: "assets/onboarding3.png",
      text1: "Hire authorized Agent",
      text2:
          "Property box provides agent services to deal the property on your behalf",
    ),
    const Page(
      image: "assets/onboarding4.png",
      text1: "Avail home services",
      text2:
          "Property verification, legality, loans and documentation at your door step",
    ),
    const Page(
      image: "assets/onboarding5.png",
      text1: "Sell your property in 1 click",
      text2: "Our representative uploads property at your foor step",
    )
  ];

  final PageController _controller = PageController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202526),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_backspace)),
                  (_currentPage == 5)
                      ? const SizedBox(width: 50)
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.jumpToPage(4);
                            });
                          },
                          child: const Text("Skip",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              )),
                        )
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page + 1;
                    });
                  },
                  itemCount: list.length,
                  itemBuilder: (context, index) => list[index]),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (_currentPage == 1) ? activeIndicator() : inactiveIndicator(),
                (_currentPage == 2) ? activeIndicator() : inactiveIndicator(),
                (_currentPage == 3) ? activeIndicator() : inactiveIndicator(),
                (_currentPage == 4) ? activeIndicator() : inactiveIndicator(),
                (_currentPage == 5) ? activeIndicator() : inactiveIndicator(),
              ],
            ),
            const SizedBox(height: 60),
            (_currentPage == 5)
                ? OnboardingButton(
                    text: 'Sign up',
                    textColor: const Color(0xFF2AB0E4),
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.login);
                    },
                  )
                : OnboardingButton(
                    text: 'Next',
                    textColor: Colors.white,
                    onTap: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget activeIndicator() {
    return AnimatedContainer(
      height: 5,
      width: 18,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFF2AB0E4)),
      curve: Curves.ease,
      duration: const Duration(milliseconds: 500),
    );
  }
}

Widget inactiveIndicator() {
  return Container(
    width: 5,
    height: 5,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color(0xFFFFFFFF).withOpacity(0.54)),
  );
}

class Page extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;

  const Page({
    Key? key,
    required this.image,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 5, left: 10, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: const Color(0xFF000000).withOpacity(0.25)),
            ],
            color: const Color(0xFF202526),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(child: Image.asset(image)),
            const SizedBox(height: 20),
            Text(
              text1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(text2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 0.4))
          ],
        ),
      ),
    );
  }
}

class OnboardingButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final Color color;
  final void Function()? onTap;
  const OnboardingButton(
      {required this.text,
      required this.textColor,
      this.width = 140,
      this.height = 43,
      this.onTap,
      this.color = const Color(0xFF202526),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 43,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 0,
                blurStyle: BlurStyle.normal,
                color: Color(0xFF383F45)),
          ],
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.4)),
        ),
      ),
    );
  }
}
