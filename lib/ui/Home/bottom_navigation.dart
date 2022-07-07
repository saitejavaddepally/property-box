import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:property_box/ui/Home/home.dart';
import 'package:property_box/ui/Home/sell_screen.dart';

class BottomBar extends StatefulWidget {
  bool isIndexGiven;
  int index;
  BottomBar({Key? key, required this.isIndexGiven, required this.index})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  List screens = <Widget>[
    const Home(),
    const SellScreen(),
    Container(color: Colors.yellow),
    Container(color: Colors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF202526),
        bottomNavigationBar: SizedBox(
          height: 72,
          child: BottomNavigationBar(
              currentIndex:
                  (widget.isIndexGiven) ? widget.index : _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.15,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.15,
              ),
              selectedItemColor: const Color(0xFF2AB0E4),
              unselectedItemColor: Colors.white.withOpacity(0.3),
              backgroundColor: const Color(0xFF202526),
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset("assets/home.png", height: 24, width: 24),
                    activeIcon: Image.asset("assets/home_active.png",
                        height: 24, width: 24),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/properties.png",
                        height: 24, width: 24),
                    activeIcon: Image.asset("assets/properties_active.png",
                        height: 24, width: 24),
                    label: "Properties"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/projects.png",
                        height: 24, width: 24),
                    activeIcon: Image.asset("assets/projects.png",
                        height: 24, width: 24),
                    label: "Projects"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/chat.png", height: 24, width: 24),
                    activeIcon:
                        Image.asset("assets/chat.png", height: 24, width: 24),
                    label: "Chats"),
              ]),
        ),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child),
          child: screens[_currentIndex],
        ));
  }
}
