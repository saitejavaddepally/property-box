import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_box/components/custom_neumorphic_button.dart';
import 'package:property_box/components/custom_neu_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_box/route_generator.dart';

import '../components/custom_button.dart';
import '../services/loction_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String name = '';
  String referralCode = '';
  String location = '';
  bool isLoading = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  Future<String?> getCurrentLocation() async {
    try {
      final location = GetUserLocation();
      final Position position = await location.determinePosition();

      final address = await location.getAddressFromCoordinates(
          LatLng(position.latitude, position.longitude));
      return address;
    } on Exception catch (e) {
      if (e.toString() == 'Location services are disabled.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please Turn On Location Service First")));
      } else if (e.toString() == 'Location permissions are denied') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Please Allow Location Permission otherwise you didn't use this feature.")));
      } else if (e.toString() ==
          'Location permissions are permanently denied, we cannot request permissions.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Sorry You are not allowed to use this feature because you didn't allow permission.")));
      }
      return null;
    }
  }

  Future<String?> getMapLocation() async {
    final String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Position>(
            future: GetUserLocation().determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PlacePicker(
                  apiKey: 'AIzaSyCBMs8s8SbqSXLzoygoqc20EvzqBY5wBX0',
                  onPlacePicked: (result) {
                    Navigator.of(context).pop(result.formattedAddress);
                  },
                  hintText: "Search",
                  enableMapTypeButton: false,
                  initialPosition:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  useCurrentLocation: true,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFF202526),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/box.png"),
                        CustomButton(
                                text: "help",
                                onClick: () {
                                  Navigator.pushNamed(context, '/help');
                                },
                                width: 48,
                                height: 48,
                                isIcon: true,
                                rounded: true,
                                shadowColor: Colors.white.withOpacity(0.4),
                                color: const Color(0xFF202526))
                            .use(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("create new account",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(children: [
                          const SizedBox(width: 5),
                          Image.asset("assets/flag-india.png"),
                          const Text(
                            " (+91)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomNeumorphicTextField(
                              controller: _phoneNumberController,
                              borderradius: 30,
                              hint: 'Enter your number',
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                              validator: (number) {
                                if (number == null ||
                                    number.isEmpty ||
                                    number.length != 10) {
                                  return "Enter Correct Mobile Number";
                                }
                                return null;
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomNeumorphicTextField(
                          controller: _nameController,
                          borderradius: 30,
                          hint: 'Enter your name',
                          onChanged: (value) {
                            name = value;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomNeumorphicTextField(
                          controller: _locationController,
                          readOnly: true,
                          onTap: () async {
                            final result = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const CustomMapDialog());

                            if (result == 1) {
                              setState(() => isLoading = true);
                              final res = await getCurrentLocation();
                              setState(() => isLoading = false);
                              if (res != null && res.isNotEmpty) {
                                _locationController.text = res;
                              }
                            }
                            if (result == 2) {
                              final res = await getMapLocation();
                              if (res != null && res.isNotEmpty) {
                                _locationController.text = res;
                              }
                            }
                          },
                          borderradius: 30,
                          hint: 'Choose location',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Choose location";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomNeumorphicTextField(
                          controller: _referralCodeController,
                          borderradius: 30,
                          hint: '    Referral Code (optional)',
                          onChanged: (value) {
                            referralCode = value;
                          },
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.maxFinite,
                          height: 43,
                          child: CustomNeumorphicButtom(
                            borderRadius: 30,
                            buttonText: 'Sign In',
                            buttonColor: const Color(0xFF2AB0E4),
                            shadowColor: Colors.white.withOpacity(0.5),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                print(_nameController.text);
                                print(_phoneNumberController.text);
                                print(_locationController.text);
                                Navigator.pushNamed(context, RouteName.otp);
                              }
                            },
                          ),
                        ),
                        // const SizedBox(height: 30),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Flexible(
                        //           child: Image.asset("assets/member.png",
                        //               height: 70))
                        //     ]),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // const Center(
                        //     child: CustomNeumorphicButtom(
                        //         buttonText: 'Sign up',
                        //         buttonColor: Color(0xFF111111),
                        //         shadowColor: Color(0xFF111111))),
                        // const SizedBox(
                        //   height: 40,
                        // ),
                        // Center(
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width * 0.7,
                        //     height: 50,
                        //     child: Column(
                        //       children: const [
                        //         Center(
                        //           child: Text(
                        //             'By clicking signup you agree for our ',
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //         ),
                        //         Center(
                        //           child: Text(
                        //             'Terms & Conditions',
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomMapDialog extends StatelessWidget {
  const CustomMapDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF202526),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                  title: const Text("Enter Current Location",
                      style: TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, 1)),
              ListTile(
                  title: const Text(
                    "Choose Current Location From Map",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pop(context, 2))
            ],
          ),
        ),
      ),
    );
  }
}
