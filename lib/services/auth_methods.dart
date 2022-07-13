// ignore_for_file: await_only_futures

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<String?> getUserId() async {
    return await _auth.currentUser?.uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
