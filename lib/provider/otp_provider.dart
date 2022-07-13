import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  final List<int> _otp = [];

  UnmodifiableListView<int> get otp => UnmodifiableListView(_otp);

  void pushToOtp(int number) {
    if (_otp.length < 6) {
      _otp.add(number);
      notifyListeners();
    }
  }

  void popFromOtp() {
    if (_otp.isNotEmpty) {
      _otp.removeLast();
      notifyListeners();
    }
  }

  Future<bool> checkOtp(String verificationId) async {
    final auth = FirebaseAuth.instance;
    if (_otp.length == 6) {
      var userCode =
          int.parse("${otp[0]}${otp[1]}${otp[2]}${otp[3]}${otp[4]}${otp[5]}");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userCode.toString());

      try {
        UserCredential _userCredential =
            await auth.signInWithCredential(credential);
        if (_userCredential.additionalUserInfo!.isNewUser) {
          return true;
        }
        return false;
      } catch (e) {
        return Future.error("Enter Correct Otp");
      }
    } else {
      return Future.error("Please Enter Otp");
    }
  }
}

class OtpTimer extends ChangeNotifier {
  static const maxSecond = 30;
  int _seconds = maxSecond;
  Timer? timer;

  OtpTimer() {
    startTimer();
  }

  int get seconds => _seconds;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      }
    });
  }

  void resetTimer() {
    _seconds = 30;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
