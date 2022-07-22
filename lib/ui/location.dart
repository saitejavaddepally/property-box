import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../components/neu_circular_button.dart';
import '../theme/colors.dart';

class LocationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const LocationScreen(
      {required this.latitude, required this.longitude, Key? key})
      : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  final GooglePlace _searchPlaces =
      GooglePlace("AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0");

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  // Future<Map<String, dynamic>> getPlotLocation() async {
  //   var number = await SharedPreferencesHelper().getCurrentPage();
  //   print("number is $number");
  //   List data = await FirestoreDataProvider()
  //       .getPlotPagesInformation(int.parse(number!));
  //   Map locationData = data[0];
  //   double _lat = locationData['latitude'];
  //   double _long = locationData['longitude'];
  //   print("Am I here $_lat and $_long");

  //   return {"latitude": _lat, "longitude": _long};
  // }

  Future<void> getNearbyLocations(String type, double color) async {
    _markers = [_markers.first];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Finding Nearby $type"),
        duration: const Duration(seconds: 1)));
    NearBySearchResponse? result = await _searchPlaces.search.getNearBySearch(
      Location(
        lat: widget.latitude,
        lng: widget.longitude,
      ),
      1200,
      type: type,
    );
    List<Marker> searchList = [];

    if (result != null) {
      String status = result.status!;
      if (status == "OK") {
        for (int i = 0; i < result.results!.length; i++) {
          searchList.add(
            Marker(
              markerId: MarkerId(
                result.results![i].placeId.toString(),
              ),
              position: LatLng(
                result.results![i].geometry!.location!.lat!,
                result.results![i].geometry!.location!.lng!,
              ),
              infoWindow: InfoWindow(title: result.results![i].name!),
              icon: BitmapDescriptor.defaultMarkerWithHue(color),
            ),
          );
        }

        _markers.addAll(searchList);
      } else if (status == "ZERO_RESULTS") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No $type found"),
            duration: const Duration(seconds: 1)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Somethig Went Wrong Please Try Later")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Somethig Went Wrong Please Try Later")));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 24),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/location_info.png')))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 8),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    markers: Set.from(_markers
                      ..add(Marker(
                          markerId: const MarkerId("User Location"),
                          position: LatLng(widget.latitude, widget.longitude),
                          infoWindow:
                              const InfoWindow(title: "Your Location")))),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longitude),
                      zoom: 15.0,
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 30),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: CustomColors.dark.withOpacity(0.1),
                          isNeu: true,
                          imageName: 'loc_1',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            await getNearbyLocations(
                                "hospital", BitmapDescriptor.hueAzure);
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: CustomColors.dark.withOpacity(0.1),
                          isNeu: true,
                          imageName: 'loc_2',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            await getNearbyLocations(
                                "school", BitmapDescriptor.hueCyan);
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: CustomColors.dark.withOpacity(0.1),
                          isNeu: true,
                          imageName: 'loc_3',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            await getNearbyLocations(
                                "supermarket", BitmapDescriptor.hueMagenta);
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: CustomColors.dark.withOpacity(0.1),
                          isNeu: true,
                          imageName: 'loc_4',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            await getNearbyLocations(
                                "subway_station", BitmapDescriptor.hueViolet);
                          }).use(),
                    ),
                    Expanded(
                      child: CircularNeumorphicButton(
                          color: CustomColors.dark.withOpacity(0.1),
                          isNeu: true,
                          imageName: 'loc_5',
                          width: 24,
                          padding: 8,
                          onTap: () async {
                            await getNearbyLocations(
                                "store", BitmapDescriptor.hueGreen);
                          }).use(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
