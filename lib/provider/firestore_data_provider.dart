import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:property_box/services/auth_methods.dart';

class FirestoreDataProvider {
  final _user = FirebaseFirestore.instance.collection('users');
  final _chat = FirebaseFirestore.instance.collection('chats');
  final _leads_box = FirebaseFirestore.instance.collection('leads_box');
  final _sellPlots = FirebaseFirestore.instance.collection('sell_plots');
  final _savedProperty =
      FirebaseFirestore.instance.collection('saved_property');

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

  Future<List> getAllProperties() async {
    List propertyData = [];

    final _querySnapUser = await _user.get();
    for (final _user in _querySnapUser.docs) {
      final userId = _user.id;
      final _collRefPlots = _sellPlots.doc(userId).collection('standlone');
      final _querySnapPlot = await _collRefPlots.get();

      for (var item in _querySnapPlot.docs) {
        final plotNo = item.id;
        final info = await _collRefPlots
            .doc(plotNo)
            .collection('pages_info')
            .where('box_enabled', isEqualTo: 1)
            .get();

        if (info.docs.isNotEmpty) {
          final propertyId = info.docs.first.id;
          propertyData.add(info.docs.first.data()
            ..addAll({'plotNo': plotNo, 'propertyId': propertyId}));
        }
      }
    }
    return propertyData;
  }

  Future<List> getSavedProperty() async {
    List propertyData = [];
    String? userId = await AuthMethods().getUserId();
    final _querySnap =
        await _savedProperty.doc(userId).collection('standlone').get();
    for (final docSnap in _querySnap.docs) {
      propertyData.add(docSnap.data());
    }
    return propertyData;
  }

  Future saveProperty(dynamic data) async {
    String? userId = await AuthMethods().getUserId();
    await _savedProperty.doc(userId).collection('standlone').add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> isSavedProperty(
      String propertyHolderUid, String propertyId) {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return _savedProperty
        .doc(userId)
        .collection('standlone')
        .where('uid', isEqualTo: propertyHolderUid)
        .where('propertyId', isEqualTo: propertyId)
        .snapshots();
  }

  Future removeSaved(String docId) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await _savedProperty
        .doc(userId)
        .collection('standlone')
        .doc(docId)
        .delete();
  }

  Future<String?> getUserName(String? userId) async {
    final _data = await _user.doc(userId).get();
    final uname = _data.data()?['name'];
    return uname;
  }

  Future<num> getAllChatCounter() async {
    num _totalCounter = 0;
    String? uid = await AuthMethods().getUserId();
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

  Future<String> getLatestMessage(String friendUid) async {
    String msg = "";
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
        if (data['type'] == 'image') {
          msg = 'Image';
        } else if (data['type'] == 'pdf') {
          msg = 'Pdf';
        } else if (data['type'] == 'loc') {
          msg = "Location";
        } else {
          msg = data['msg'];
        }
      }
    }
    return msg;
  }

  Future<List<dynamic>> getAllImage(userId, String plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/$plotNo/images/");
    final List<dynamic> images = List.generate(8, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      await listResult.items[i].getDownloadURL().then((value) async {
        images[i] = value;
      });
    }

    return images;
  }

  Future<List<dynamic>> getAllVideos(userId, String plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/$plotNo/videos/");
    final List<dynamic> videos = List.generate(4, (index) => null);
    final List<dynamic> previousVideoNames = List.generate(4, (index) => null);

    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousVideoNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        videos[i] = value;
      });
    }

    return [previousVideoNames, videos];
  }

  Future<List<dynamic>> getAllDocs(userId, String plotNo) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("sell_images/$userId/standlone/$plotNo/docs/");
    final List<dynamic> docs = List.generate(4, (index) => null);
    final List<dynamic> previousDocNames = List.generate(4, (index) => null);
    final listResult = await storageRef.listAll();

    for (int i = 0; i < listResult.items.length; i++) {
      previousDocNames[i] = listResult.items[i].name;
      await listResult.items[i].getDownloadURL().then((value) async {
        docs[i] = value;
      });
    }

    return [previousDocNames, docs];
  }
}
