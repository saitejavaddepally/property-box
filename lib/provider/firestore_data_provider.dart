import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:property_box/services/auth_methods.dart';

class FirestoreDataProvider {
  static final _user = FirebaseFirestore.instance.collection('users');
  final _chat = FirebaseFirestore.instance.collection('chats');
  final _leads_box = FirebaseFirestore.instance.collection('leads_box');
  final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');
  final _savedProperty =
      FirebaseFirestore.instance.collection('saved_property');
  static final _projects = FirebaseFirestore.instance.collection('projects');

  Future<Map<String, dynamic>?> getUserDetails() async {
    String? userId = await AuthMethods().getUserId();
    final docSnap = await _user.doc(userId).get();
    if (docSnap.exists) {
      return docSnap.data();
    }
    return {};
  }

  Future<void> saveLead(
      String? uidOfPropertyAdder, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('leads_box')
          .doc(uidOfPropertyAdder)
          .collection('standlone')
          .add(data);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isLeadAlreadyCreated(
      String plotOwnerUid, String interstedUserUid, String propertyId) async {
    final querySnap = await _leads_box
        .doc(plotOwnerUid)
        .collection('standlone')
        .where('interestedUserUid', isEqualTo: interstedUserUid)
        .where('propertyId', isEqualTo: propertyId)
        .get();
    if (querySnap.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List> getAllProjects() async {
    final querySnap = await _projects.get();
    final allData = querySnap.docs
        .map((doc) => doc.data()..addAll({'docId': doc.id}))
        .toList();
    return allData;
  }

  static Future<List<Map<String, dynamic>>> getSubscribedUser(
      List users) async {
    final _querySnap =
        await _user.where(FieldPath.documentId, whereIn: users).get();
    return _querySnap.docs.map((e) => e.data()).toList();
  }

  Future<String?> getUserName(String? userId) async {
    final _data = await _user.doc(userId).get();
    final uname = _data.data()?['name'];
    return uname;
  }

  Future<num> getAllChatCounter() async {
    num _totalCounter = 0;
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    final _currentUser = await _user.doc(uid).get();
    final _currentUserData = _currentUser.data();
    final _querySnapUser = await _user.get();
    for (final u in _querySnapUser.docs) {
      final id = u.id;
      final count = _currentUserData?[id];
      if (count == null) {
      } else {
        _totalCounter += count;
      }
    }
    return _totalCounter;
  }

  Future<num> getParticularChatCounter(String uid) async {
    String? currentUser = await AuthMethods().getUserId();
    final docSnap = await _user.doc(currentUser).get();
    final result = docSnap.data()?[uid];
    if (result == null) {
      return 0;
    } else {
      return result;
    }
  }

  Future<void> clearParticularChatCounter(String uid) async {
    try {
      String? currentUser = await AuthMethods().getUserId();
      await _user.doc(currentUser).update({uid: 0});
    } catch (e) {
      print(e);
    }
  }

  Future<List> getLatestMessage(String friendUid) async {
    List msg = [null, ''];
    String? currentUid = await AuthMethods().getUserId();
    final querySnapshot = await _chat
        .where('users', isEqualTo: {friendUid: null, currentUid: null})
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final chatDocId = querySnapshot.docs.single.id;
      final querySnap = await _chat
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .limit(1)
          .get();

      if (querySnap.docs.isNotEmpty) {
        final data = querySnap.docs.first.data();
        msg[0] = data['createdOn'];

        if (data['type'] == 'image') {
          msg[1] = 'Image';
        } else if (data['type'] == 'pdf') {
          msg[1] = 'Pdf';
        } else if (data['type'] == 'loc') {
          msg[1] = 'location';
        } else {
          msg[1] = data['msg'];
        }
      }
    }
    return msg;
  }
}
