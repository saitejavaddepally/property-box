import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:property_box/ui/Home/bottom_navigation.dart';
import 'package:property_box/ui/login.dart';
import 'package:property_box/ui/otp.dart';
import 'package:property_box/ui/realtor_card.dart';
import 'package:property_box/ui/sign_up.dart';

class RouteName {
  static const String bottomBar = '/bottomBar';
  static const String otp = '/otp';
  static const String signUp = '/sign_up';
  static const String realtorCard = '/realtor_card';
  static const String login = '/login';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.bottomBar:
        return PageTransition(
            child: BottomBar(index: 0, isIndexGiven: false),
            type: PageTransitionType.leftToRight);

      case RouteName.otp:
        return PageTransition(
            child: const Otp(), type: PageTransitionType.leftToRight);

      case RouteName.signUp:
        return PageTransition(
            child: const SignUpForm(), type: PageTransitionType.leftToRight);

      case RouteName.realtorCard:
        return PageTransition(
            child: const RealtorCard(), type: PageTransitionType.leftToRight);

      case RouteName.login:
        return PageTransition(
            child: const Login(), type: PageTransitionType.leftToRight);

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(child: Text('ERROR')),
      );
    });
  }
}
