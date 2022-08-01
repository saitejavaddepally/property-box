import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/route_generator.dart';
import 'package:property_box/services/auth_methods.dart';
import 'package:property_box/services/local_notification_service.dart';
import 'package:property_box/theme/colors.dart';
import 'package:property_box/ui/Home/bottom_navigation.dart';
import 'package:property_box/ui/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';

// works when the app is in background open or close doesn't matter
Future<void> backgroundHandler(RemoteMessage message) async {
  print("OnBackgroundMessage");
  if (message.notification != null) {
    print(message.notification!.body);
    print(message.notification!.title);
    print(message.data);
  }
}

Future<void> main() async {
  const Settings(persistenceEnabled: true);
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      theme: NeumorphicThemeData(
        baseColor: CustomColors.dark,
        defaultTextColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: CustomColors.dark,
        defaultTextColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      supportedLocales: const [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<User?>(
        future: AuthMethods().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomBar(index: 0);
          } else {
            return const Onboarding();
          }
        },
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
