import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/custom_button.dart';
import 'package:property_box/components/custom_text_field.dart';
import 'package:property_box/components/custom_title.dart';
import 'package:property_box/route_generator.dart';
import 'package:property_box/theme/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _phoneNumber;
  String? _dialCode = '+91';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 40,
          child: Column(
            children: const [
              Text('By continuing, you agree to our',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.white)),
              Text('Terms & service and privacy policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.white))
            ],
          ),
        ),
        backgroundColor: CustomColors.dark,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(fit: StackFit.passthrough, children: [
                      Center(child: Image.asset('assets/login.png')),
                      Center(
                        child: Image.asset('assets/property_logo.png',
                            width: 185, height: 50),
                      )
                    ]),
                  ),
                  const CustomTitle(text: 'Log in or Sign up'),
                  const SizedBox(height: 20),
                  Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: -4,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        shadowDarkColorEmboss: Colors.black,
                        shadowLightColorEmboss: Colors.white.withOpacity(0.4),
                        intensity: 0.7,
                        color: CustomColors.dark),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 2, bottom: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white.withOpacity(0.1)),
                            child: CountryCodePicker(
                              onChanged: (CountryCode countryCode) {
                                _dialCode = countryCode.dialCode;
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: '+91',

                              favorite: const ['+91', 'IN'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              textStyle: const TextStyle(color: Colors.white),
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,

                              flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Form(
                            key: _formKey,
                            child: Flexible(
                                child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: CustomTextField(
                                borderradius: 30,
                                hint: "Enter Mobile Number",
                                keyboardType: TextInputType.number,
                                controller: _phoneNumberController,
                                style: const TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  _phoneNumber = value;
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
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                          text: 'Continue',
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, RouteName.otp,
                                  arguments: [
                                    _phoneNumberController.text,
                                    _dialCode
                                  ]);
                            }
                          },
                          color: CustomColors.lightBlue,
                          width: double.maxFinite,
                          textColor: Colors.black,
                          shadowColor: Colors.white.withOpacity(0.7),
                          height: 43)
                      .use(),
                ],
              ),
            ),
          ),
        ));
  }
}
