import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:property_box/ui/Home/Chat/chat_detail.dart';
import 'package:property_box/ui/Home/bottom_navigation.dart';
import 'package:property_box/ui/documents.dart';
import 'package:property_box/ui/emi.dart';
import 'package:property_box/ui/gallery.dart';
import 'package:property_box/ui/interested.dart';
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
  static const String chatDetail = '/chat_detail';
  static const String interested = '/interested';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.bottomBar:
        {
          if (args is int) {
            return PageTransition(
                child: BottomBar(index: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

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

      case RouteName.interested:
        {
          if (args is Map<String, dynamic>) {
            return PageTransition(
                child: Interested(data: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.location:
        {
          if (args is List) {
            return PageTransition(
                child: LocationScreen(latitude: args[0], longitude: args[1]),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.gallery:
        {
          if (args is List) {
            return PageTransition(
                child: GalleryScreen(images: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.emi:
        {
          if (args is int) {
            return PageTransition(
                child: EMI(plotPrice: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.documents:
        {
          if (args is List) {
            return PageTransition(
                child: Documents(docs: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.tour:
        {
          if (args is List) {
            return PageTransition(
                child: Tour(videos: args),
                type: PageTransitionType.leftToRight);
          }
          return _errorRoute();
        }

      case RouteName.chatDetail:
        if (args is List) {
          return PageTransition(
              child: ChatDetail(friendUid: args[0], friendName: args[1]),
              type: PageTransitionType.leftToRight);
        }
        return _errorRoute();

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
