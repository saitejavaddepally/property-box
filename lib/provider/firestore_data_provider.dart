import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:property_box/services/auth_methods.dart';

class FirestoreDataProvider {
  final _userCollRef = FirebaseFirestore.instance.collection('users');
  // Future<List> getAllProperties() async {
  //   List propertyData = [];
  //   String? userId = await AuthMethods().getUserId();
  //   final collRef = FirebaseFirestore.instance
  //       .collection('sell_plots')
  //       .doc(userId)
  //       .collection('standlone');

  //   final querySnap = await collRef.get();

  //   for (var item in querySnap.docs) {
  //     final plotNo = item.id;
  //     final info = await collRef
  //         .doc(plotNo)
  //         .collection('pages_info')
  //         .where('box_enabled', isEqualTo: 1)
  //         .get();

  //     final imageList = await getAllImage(userId, plotNo);
  //     imageList.removeWhere((value) => value == null);

  //     if (info.docs.isNotEmpty) {
  //       propertyData.add(info.docs.first.data()..addAll({'image': imageList}));
  //     }
  //   }
  //   return propertyData;
  // }

  Future<void> getAllProperties() async {
    List propertyData = [];

    final _querySnapUser = await _userCollRef.get();
    for (final _user in _querySnapUser.docs) {
      print(_user.id);
    }

    // String? userId = await AuthMethods().getUserId();
    // final collRef = FirebaseFirestore.instance
    //     .collection('sell_plots')
    //     .doc(userId)
    //     .collection('standlone');

    // final querySnap = await collRef.get();

    // for (var item in querySnap.docs) {
    //   final plotNo = item.id;
    //   final info = await collRef
    //       .doc(plotNo)
    //       .collection('pages_info')
    //       .where('box_enabled', isEqualTo: 1)
    //       .get();

    //   final imageList = await getAllImage(userId, plotNo);
    //   imageList.removeWhere((value) => value == null);

    //   if (info.docs.isNotEmpty) {
    //     propertyData.add(info.docs.first.data()..addAll({'image': imageList}));
    //   }
    // }
    // return propertyData;
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
