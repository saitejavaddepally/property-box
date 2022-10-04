import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;

class GetUserLocation {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<List?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();

      final address = await location.getAddressFromCoordinates(
          LatLng(position.latitude, position.longitude));
      return [address, position.latitude, position.longitude];
    } catch (e) {
      if (e.toString() == 'Location services are disabled.') {
        Fluttertoast.showToast(msg: "Please Turn On Location Service First");
        await Geolocator.openLocationSettings();
      } else if (e.toString() == 'Location permissions are denied') {
        Fluttertoast.showToast(
            msg:
                "Please Allow Location Permission otherwise you didn't use this feature.");
      } else if (e.toString() ==
          'Location permissions are permanently denied, we cannot request permissions.') {
        Fluttertoast.showToast(
            msg:
                "Sorry You are not allowed to use this feature because you didn't allow permission.");
      }
      return null;
    }
  }

  static Future<List> getMapLocation(BuildContext context) async {
    final List result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Position>(
            future: GetUserLocation().determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: 'AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0',
                  onPlacePicked: (result) {
                    Navigator.pop(context, [
                      result.formattedAddress,
                      result.geometry?.location.lat,
                      result.geometry?.location.lng
                    ]);
                  },
                  hintText: "Search",
                  enableMapTypeButton: false,
                  initialPosition:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  useCurrentLocation: true,
                );
              } else if (snapshot.hasError) {
                if (snapshot.error == 'Location services are disabled.') {
                  Geolocator.openLocationSettings()
                      .then((value) => Navigator.pop(context));
                }
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );

    return result;
  }

  Future<String> getAddressFromCoordinates(LatLng userLocation) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${userLocation.latitude},${userLocation.longitude}&sensor=true&key=AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0');
    var _response = await http.get(url);
    var data = _response.body;
    Map<String, dynamic> data2 = jsonDecode(data);
    List<dynamic> list = data2['results'];

    var result = list[0]['formatted_address'].toString();
    return result;
  }
}
