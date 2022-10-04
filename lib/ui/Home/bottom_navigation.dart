import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:property_box/provider/firestore_data_provider.dart';
import 'package:property_box/ui/Home/Chat/people.dart';
import 'package:property_box/ui/Home/home.dart';
import 'package:property_box/ui/Home/projects.dart';
import 'package:property_box/ui/Home/property_screen.dart';

import '../../services/local_notification_service.dart';

class BottomBar extends StatefulWidget {
  int index;
  BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List screens = <Widget>[
    const Home(),
    const PropertyScreen(),
    const Project(),
    const People(),
  ];

  @override
  initState() {
    super.initState();

    setupToken();

    //gives u the message on which user taps and it opened the app from terminated state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    //work when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await LocalNotificationService.display(message);
    });

    //when the app is in the background but not terminated and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {}
    });
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF202526),
        bottomNavigationBar: FutureBuilder<num>(
            future: FirestoreDataProvider().getAllChatCounter(),
            initialData: 0,
            builder: (context, snapshot) {
              return SizedBox(
                height: 72,
                child: BottomNavigationBar(
                    currentIndex: widget.index,
                    onTap: (index) {
                      setState(() {
                        widget.index = index;
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
                          icon: Image.asset("assets/home.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/home_active.png",
                              height: 24, width: 24),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: Image.asset("assets/properties.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset(
                              "assets/properties_active.png",
                              height: 24,
                              width: 24),
                          label: "Properties"),
                      BottomNavigationBarItem(
                          icon: Image.asset("assets/projects.png",
                              height: 24, width: 24),
                          activeIcon: Image.asset("assets/projects.png",
                              height: 24, width: 24),
                          label: "Projects"),
                      BottomNavigationBarItem(
                          icon: Stack(children: [
                            Image.asset("assets/chat.png",
                                height: 24, width: 24),
                            if (snapshot.data != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )),
                              ),
                          ]),
                          activeIcon: Stack(children: [
                            Image.asset("assets/chat.png",
                                height: 24, width: 24),
                            if (snapshot.data != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )),
                              ),
                          ]),
                          label: "Chats"),
                    ]),
              );
            }),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child),
          child: screens[widget.index],
        ));
  }
}
