import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_box/route_generator.dart';
import 'package:property_box/ui/onboarding.dart';
import 'package:provider/provider.dart';

import '../provider/otp_provider.dart';

class Otp extends StatefulWidget {
  final List args;
  const Otp({required this.args, Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? _phoneNumber;
  String? _dialCode;
  String? _verificationId;
  int? _resendToken;
  bool isLoading = false;

  Future<void> verifyUser({int? resendToken}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _dialCode! + _phoneNumber!,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        //   print("verification complete");
        //   UserCredential userCredentials =
        //       await _auth.signInWithCredential(credential);

        //   Navigator.pushReplacementNamed(context, '/');
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed" + e.code);
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Phone Number')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something Went Wrong" + e.code.toString())));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        print("code sent");
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Code auto retreival timeout");
        _verificationId = verificationId;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _phoneNumber = widget.args[0];
    _dialCode = widget.args[1];
    verifyUser().then((value) {}).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OtpTimer()),
          ChangeNotifierProvider(create: (context) => OtpProvider())
        ],
        builder: (context, child) {
          final otpProvider = Provider.of<OtpProvider>(context, listen: false);
          return Scaffold(
            backgroundColor: const Color(0xFF202526),
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: const Color(0xFF000000).withOpacity(0.2),
                          width: double.maxFinite,
                          height: 150,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/property_logo.png",
                                  width: 190,
                                  height: 50,
                                ),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "enter otp send to your mobile\nnumber ${_phoneNumber!.replaceRange(2, 8, '******')}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Consumer<OtpProvider>(builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(0))
                                        ? value.otp[0].toString()
                                        : ''),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                width: 6,
                                child: Divider(
                                    color: const Color(0xFF2AB0E4)
                                        .withOpacity(0.3),
                                    thickness: 1.5),
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(1))
                                        ? value.otp[1].toString()
                                        : ''),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                width: 6,
                                child: Divider(
                                    color: const Color(0xFF2AB0E4)
                                        .withOpacity(0.3),
                                    thickness: 1.5),
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(2))
                                        ? value.otp[2].toString()
                                        : ''),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                width: 6,
                                child: Divider(
                                    color: const Color(0xFF2AB0E4)
                                        .withOpacity(0.3),
                                    thickness: 1.5),
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(3))
                                        ? value.otp[3].toString()
                                        : ''),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                width: 6,
                                child: Divider(
                                    color: const Color(0xFF2AB0E4)
                                        .withOpacity(0.3),
                                    thickness: 1.5),
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(4))
                                        ? value.otp[4].toString()
                                        : ''),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                width: 6,
                                child: Divider(
                                    color: const Color(0xFF2AB0E4)
                                        .withOpacity(0.3),
                                    thickness: 1.5),
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                child: buildTextField(
                                    (value.otp.asMap().containsKey(5))
                                        ? value.otp[5].toString()
                                        : ''),
                              )
                            ],
                          );
                        }),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<OtpTimer>(
                                builder: (context, value, child) {
                              return Flexible(
                                  child: OnboardingButton(
                                      text: 'Resend',
                                      height: 36,
                                      width: 98,
                                      textColor: const Color(0xFF27B4E8),
                                      onTap: (value.seconds == 0)
                                          ? () {
                                              value.resetTimer();
                                              verifyUser(
                                                      resendToken: _resendToken)
                                                  .then((value) {})
                                                  .catchError((error) {});
                                            }
                                          : null));
                            }),
                            const SizedBox(width: 20),
                            Consumer<OtpTimer>(
                                builder: (context, value, child) {
                              return buildTimer(value);
                            }),
                            const SizedBox(width: 20),
                            Flexible(
                                child: OnboardingButton(
                              text: 'Submit',
                              textColor: Colors.black,
                              height: 36,
                              width: 98,
                              color: const Color(0xFF2AB0E4),
                              onTap: () async {
                                if (_verificationId != null) {
                                  try {
                                    setState(() => isLoading = true);
                                    bool result = await otpProvider
                                        .checkOtp(_verificationId!);

                                    Navigator.pushNamed(
                                        context,
                                        (result == true)
                                            ? RouteName.signUp
                                            : RouteName.bottomBar);
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                    setState(() => isLoading = false);
                                  }
                                }
                              },
                            )),
                          ],
                        ),
                        const SizedBox(height: 70),
                        Wrap(
                          spacing: 50,
                          children: [
                            KeyPad(
                                number: '1',
                                onTap: () => otpProvider.pushToOtp(1)),
                            KeyPad(
                                number: '2',
                                onTap: () => otpProvider.pushToOtp(2)),
                            KeyPad(
                                number: '3',
                                onTap: () => otpProvider.pushToOtp(3)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Wrap(
                          spacing: 50,
                          children: [
                            KeyPad(
                                number: '4',
                                onTap: () => otpProvider.pushToOtp(4)),
                            KeyPad(
                                number: '5',
                                onTap: () => otpProvider.pushToOtp(5)),
                            KeyPad(
                                number: '6',
                                onTap: () => otpProvider.pushToOtp(6)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Wrap(
                          spacing: 50,
                          children: [
                            KeyPad(
                                number: '7',
                                onTap: () => otpProvider.pushToOtp(7)),
                            KeyPad(
                                number: '8',
                                onTap: () => otpProvider.pushToOtp(8)),
                            KeyPad(
                                number: '9',
                                onTap: () => otpProvider.pushToOtp(9)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Wrap(
                          spacing: 50,
                          children: [
                            const SizedBox(width: 60),
                            KeyPad(
                                number: '0',
                                onTap: () => otpProvider.pushToOtp(0)),
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: Center(
                                child: NeumorphicButton(
                                  child: const Icon(Icons.backspace_outlined,
                                      size: 18, color: Colors.white),
                                  onPressed: () => otpProvider.popFromOtp(),
                                  style: NeumorphicStyle(
                                      color: const Color(0xFF202526),
                                      shape: NeumorphicShape.flat,
                                      shadowLightColor:
                                          Colors.white.withOpacity(0.4),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(20))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildTextField(String number) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          color: const Color(0xFF2AB0E4).withOpacity(0.3)),
      child: Center(
          child: Text(number,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white))),
    );
  }

  Widget buildTime(seconds) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: '$seconds',
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.4,
                color: Colors.white)),
        const TextSpan(
            text: 's',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.4,
                color: Colors.white))
      ]),
    );
  }

  Widget buildTimer(OtpTimer value) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: const Color(0xFF202526),
          shadowLightColor: Colors.black,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40))),
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF202526),
          borderRadius: BorderRadius.circular(40),
          //boxShadow: shadow2,
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  value: 1 - value.seconds / OtpTimer.maxSecond,
                  strokeWidth: 3,
                  color: const Color(0xFF202526),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF202526)),
                  backgroundColor: const Color(0xFF2AB0E4),
                ),
              ),
            ),
            Center(child: buildTime(value.seconds))
          ],
        ),
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  final String number;
  final void Function() onTap;

  const KeyPad({Key? key, required this.number, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Center(
        child: NeumorphicButton(
          child: Text(
            number,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFFFFFFFF),
                letterSpacing: 0.4),
          ),
          onPressed: onTap,
          style: NeumorphicStyle(
              color: const Color(0xFF202526),
              shape: NeumorphicShape.flat,
              shadowLightColor: Colors.white.withOpacity(0.4),
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(30))),
        ),
      ),
    );
  }
}
