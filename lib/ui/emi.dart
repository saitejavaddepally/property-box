import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:property_box/components/custom_selector.dart';

import '../components/custom_button.dart';
import '../components/neu_circular_button.dart';
import '../helper/contants.dart';
import '../theme/colors.dart';

class EMI extends StatefulWidget {
  const EMI({Key? key}) : super(key: key);

  @override
  State<EMI> createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  final List<num> _roiMenuItems = [6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0];
  num _roiChosenValue = 6.5;

  final List<String> _tenureMenuItems = [
    '5 yrs',
    '10 yrs',
    '15 yrs',
    '20 yrs',
  ];
  late String _tenureChosenValue = '5 yrs';

  Future<int?> getCurrentPlotPrice() async {
    // var number = await SharedPreferencesHelper().getCurrentPage();
    // print("number is $number");
    // List data = await FirestoreDataProvider()
    //     .getPlotPagesInformation(int.parse(number!));
    // String price = data[0]['price'];

    // return int.parse(price);
    return 10000;
  }

  int emi(int price, int years, double roi) {
    roi = roi / 12 / 100;
    final loanEMI =
        price * roi * pow(1 + roi, years * 12) / (pow(1 + roi, years * 12) - 1);
    return loanEMI.floor().toInt();
  }

  int getPercentagePrice(int price, int percent) {
    return (price * percent / 100).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.dark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_backspace_rounded,
                          color: Colors.white))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('ROI',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                            width: 100,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CustomSelector(
                                    dropDownItems: _roiMenuItems,
                                    color: CustomColors.dark,
                                    onChanged: (number) {
                                      setState(() {
                                        _roiChosenValue = number!;
                                      });
                                    },
                                    chosenValue: _roiChosenValue)
                                .use()),
                      ),
                      const SizedBox(width: 30),
                      const Text('Tenure',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                            height: 40,
                            width: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CustomSelector(
                                    dropDownItems: _tenureMenuItems,
                                    color: CustomColors.dark,
                                    onChanged: (year) {
                                      setState(() {
                                        _tenureChosenValue = year!;
                                      });
                                    },
                                    chosenValue: _tenureChosenValue)
                                .use()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                      future: getCurrentPlotPrice(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SpinKitThreeBounce(
                            size: 30,
                            color: Colors.white,
                          );
                        }

                        final price = snapshot.data as int;
                        return Neumorphic(
                          style: NeumorphicStyle(
                              color: Colors.white.withOpacity(0.4),
                              shape: NeumorphicShape.flat,
                              shadowLightColor: Colors.black,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(10),
                              )),
                          child: Container(
                            decoration: BoxDecoration(
                                color: CustomColors.dark,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: HexColor('191E1F'),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Flexible(
                                            child: TableTitleText(
                                                text: '% of property')),
                                        Flexible(
                                          child: TableTitleText(
                                            text: 'Amount',
                                          ),
                                        ),
                                        Flexible(
                                            child: TableTitleText(text: 'EMI')),
                                      ],
                                    ),
                                  ),
                                ),
                                for (int i = 50; i <= 90; i += 10)
                                  TableRow(
                                      text1: '$i% of $price',
                                      text2: getPercentagePrice(price, i)
                                          .toString(),
                                      text3: emi(
                                              getPercentagePrice(price, i)
                                                  .toInt(),
                                              int.parse(_tenureChosenValue
                                                  .substring(0, 2)),
                                              double.parse(
                                                  _roiChosenValue.toString()))
                                          .toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: const [
                            Flexible(
                              child: Text(
                                  'To Know Actual Numbers Based On Your Requirement',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 65,
                                child: CircularNeumorphicButton(
                                  imageName: 'chat_2',
                                  padding: 0,
                                  color: CustomColors.dark,
                                  size: 40,
                                  onTap: () {},
                                  isNeu: true,
                                ).use(),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                height: 65,
                                child: CircularNeumorphicButton(
                                  imageName: 'call_2',
                                  padding: 0,
                                  color: CustomColors.dark,
                                  size: 40,
                                  onTap: () {},
                                  isNeu: true,
                                ).use(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomEMIContainer(
                      onClick: () {},
                      text:
                          'Confused which property to buy?? our property buying score will help you to choose your dream property',
                      containerColor: 'D5FFFF',
                      buttonText: 'know our services',
                      width: 151),
                  const SizedBox(height: 40),
                  CustomEMIContainer(
                      onClick: () {},
                      text:
                          'Property box is providing doorstep service for loan documentation and suidance woth leading banks collobaration.',
                      containerColor: 'FFF8D5',
                      buttonText: 'know our services',
                      width: 151),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomEMIContainer extends StatelessWidget {
  final String text;
  final String containerColor;
  final void Function() onClick;
  final String buttonText;
  final double width;

  const CustomEMIContainer(
      {required this.onClick,
      required this.text,
      required this.containerColor,
      required this.buttonText,
      this.width = 100,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: const EdgeInsets.all(5),
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          color: CustomColors.dark,
          shadowLightColor: Colors.black),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
        decoration: BoxDecoration(
            color: HexColor(containerColor),
            borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(text,
              style: TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: HexColor('1B1B1B').withOpacity(0.9))),
          const SizedBox(height: 20),
          CustomButton(
                  text: buttonText,
                  onClick: onClick,
                  color: Colors.black,
                  height: 40,
                  width: width,
                  textColor: Colors.white)
              .use()
        ]),
      ),
    );
  }
}

class TableTitleText extends StatelessWidget {
  final String text;

  const TableTitleText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white));
  }
}

class TableRow extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;

  const TableRow(
      {required this.text1, required this.text2, required this.text3, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(text1, style: style)),
            Flexible(child: Text(text2, style: style)),
            Flexible(child: Text(text3, style: style))
          ],
        ));
  }
}
