import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:property_box/ui/Home/bottom_navigation.dart';
import 'package:property_box/ui/documents.dart';
import 'package:property_box/ui/emi.dart';
import 'package:property_box/ui/gallery.dart';
import 'package:property_box/ui/location.dart';
import 'package:property_box/ui/login.dart';
import 'package:property_box/ui/otp.dart';
import 'package:property_box/ui/realtor_card.dart';
import 'package:property_box/ui/sign_up.dart';
import 'package:property_box/ui/tour.dart';

class RouteName {
  static const String bottomBar = '/bottomBar';
  static const String otp = '/otp';
  static const String signUp = '/sign_up';
  static const String realtorCard = '/realtor_card';
  static const String login = '/login';
  static const String location = '/location';
  static const String gallery = '/gallery';
  static const String emi = '/emi';
  static const String documents = '/documents';
  static const String tour = '/tour';
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
        {
          if (args is List) {
            return PageTransition(
                child: Otp(args: args), type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.signUp:
        return PageTransition(
            child: const SignUpForm(), type: PageTransitionType.leftToRight);

      case RouteName.location:
        return PageTransition(
            child: const LocationScreen(),
            type: PageTransitionType.leftToRight);

      case RouteName.gallery:
        return PageTransition(
            child: const GalleryScreen(), type: PageTransitionType.leftToRight);

      case RouteName.emi:
        return PageTransition(
            child: const EMI(), type: PageTransitionType.leftToRight);

      case RouteName.documents:
        return PageTransition(
            child: const Documents(), type: PageTransitionType.leftToRight);

      case RouteName.tour:
        return PageTransition(
            child: const Tour(), type: PageTransitionType.leftToRight);

      case RouteName.realtorCard:
        {
          if (args is Map) {
            return PageTransition(
                child: RealtorCard(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

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
