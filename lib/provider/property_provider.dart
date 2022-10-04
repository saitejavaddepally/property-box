import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:property_box/services/loction_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyScreenProvider extends ChangeNotifier {
  static final _sellPlots = FirebaseFirestore.instance.collection("sell_plots");
  static final _user = FirebaseFirestore.instance.collection("users");
  static final _userId = FirebaseAuth.instance.currentUser?.uid;
  static final _savedProperty =
      FirebaseFirestore.instance.collection('saved_property');

  PropertyScreenProvider() {
    Geolocator.getLastKnownPosition().then((Position? value) async {
      if (value != null) {
        lat = value.latitude;
        long = value.longitude;
        address = await GetUserLocation()
            .getAddressFromCoordinates(LatLng(lat!, long!));
        notifyListeners();
      }
    });
  }

  String address = 'Choose Location';
  double? lat;
  double? long;

  void updateLocation(List res) {
    address = res[0];
    lat = res[1];
    long = res[2];
    notifyListeners();
  }

  // for possession dropDown
  final List<String> _possessionDropDown = ['Possession', 'abcde'];
  String? _possessionChosenValue = 'Possession';

  String? get possessionChosenValue => _possessionChosenValue;

  UnmodifiableListView<String> get possessionDropDown =>
      UnmodifiableListView(_possessionDropDown);

  void onChangedPossession(value) {
    _possessionChosenValue = value;
    notifyListeners();
  }

  // for sort dropDown
  final List<String> _sortDropDown = ['Sort', 'abcde'];
  String? _sortChosenValue = 'Sort';

  String? get sortChosenValue => _sortChosenValue;

  UnmodifiableListView<String> get sortDropDown =>
      UnmodifiableListView(_sortDropDown);

  void onChangedSort(value) {
    _sortChosenValue = value;
    notifyListeners();
  }

  bool isSaved = false;

  toggleIsSaved() {
    isSaved = !isSaved;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getAllProperties() async {
    final propertyData = <Map<String, dynamic>>[];
    final allUsers = await _user.get();

    for (final user in allUsers.docs) {
      final uid = user.id;

      final querySnapPlot = await _sellPlots
          .doc(uid)
          .collection('standlone')
          .where('box_enabled', isEqualTo: 1)
          .get();

      for (var e in querySnapPlot.docs) {
        final data = e.data();

        final id = e.id;
        if (lat == null || long == null) {
          propertyData
              .add(data..addAll({'propertyId': id, 'propertyHolderId': uid}));
        } else {
          final lat2 = data['latitude'];
          final long2 = data['longitude'];
          final distanceInMeter =
              Geolocator.distanceBetween(lat!, long!, lat2, long2);
          final distanceInKm = distanceInMeter / 1000;
          if (distanceInKm <= 25) {
            propertyData
                .add(data..addAll({'propertyId': id, 'propertyHolderId': uid}));
          }
        }
      }
    }

    return propertyData;
  }

  Future<void> saveProperty(Map<String, dynamic> data) async {
    await _savedProperty.doc(_userId).collection('standlone').add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> isSavedProperty(
      String propertyHolderUid, String propertyId) {
    return _savedProperty
        .doc(_userId)
        .collection('standlone')
        .where('propertyHolderId', isEqualTo: propertyHolderUid)
        .where('propertyId', isEqualTo: propertyId)
        .snapshots();
  }

  Future removeSaved(String docId) async {
    await _savedProperty
        .doc(_userId)
        .collection('standlone')
        .doc(docId)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getSavedProperty() async {
    final _querySnap =
        await _savedProperty.doc(_userId).collection('standlone').get();
    return _querySnap.docs.map((e) => e.data()).toList();
  }
}

class PageNumberProvider extends ChangeNotifier {
  int page = 0;
  void onPageNumberChanged(pageNumber, reason) {
    page = pageNumber;
    notifyListeners();
  }
}
