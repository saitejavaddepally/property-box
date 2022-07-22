import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:property_box/provider/firestore_data_provider.dart';
import 'package:property_box/services/auth_methods.dart';

import '../components/custom_button.dart';
import '../route_generator.dart';
import '../theme/colors.dart';

class RealtorCard extends StatefulWidget {
  final Map data;
  const RealtorCard({required this.data, Key? key}) : super(key: key);

  @override
  State<RealtorCard> createState() => _RealtorCardState();
}

class _RealtorCardState extends State<RealtorCard> {
  PageController? _pageController;
  Color color = CustomColors.dark;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.data['index']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        body: SafeArea(
            child: Stack(children: [
          PageView.builder(
            itemCount: widget.data['data'].length,
            controller: _pageController,
            onPageChanged: (int page) {},
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final currentData = widget.data['data'][index];
              return RealtorPage(
                  image: currentData['images'][0],
                  onTapInterested: () async {
                    String? _plotOwnerUid = currentData['uid'];
                    String? _currentUid = await AuthMethods().getUserId();
                    String _plotProfilePicture =
                        currentData['plotProfilePicture'];
                    String _plotNo = currentData['plotNo'];
                    String _propertyId = currentData['propertyId'];

                    if (_plotOwnerUid == _currentUid) {
                      Fluttertoast.showToast(msg: 'This is your property');
                    } else {
                      final result = await FirestoreDataProvider()
                          .isLeadAlreadyCreated(
                              _plotOwnerUid!, _currentUid!, _propertyId);
                      if (result == true) {
                        Fluttertoast.showToast(
                            msg:
                                "You already show's your interest in this propery");
                      } else {
                        await Navigator.pushNamed(context, RouteName.interested,
                            arguments: {
                              'plotOwnerUid': _plotOwnerUid,
                              'interestedUserUid': _currentUid,
                              'profile': _plotProfilePicture,
                              'plotNo': _plotNo,
                              'propertyId': _propertyId
                            });
                        await EasyLoading.showSuccess(
                            "Lead Created Successfully",
                            duration: const Duration(seconds: 3));
                      }
                    }
                  },
                  onTapChat: () async {
                    String? _currentUserId = await AuthMethods().getUserId();
                    String? _userId = currentData['uid'];
                    String? uname =
                        await FirestoreDataProvider().getUserName(_userId);
                    if (_currentUserId == _userId) {
                      Fluttertoast.showToast(msg: "You can't chat to own");
                    } else {
                      Navigator.pushNamed(context, RouteName.chatDetail,
                          arguments: [_userId, uname ?? '']);
                    }
                  },
                  onTapLocation: () {
                    final _latitude = currentData['latitude'];
                    final _longitude = currentData['longitude'];
                    Navigator.pushNamed(context, RouteName.location,
                        arguments: [_latitude, _longitude]);
                  },
                  onTapGallery: () {
                    Navigator.pushNamed(context, RouteName.gallery,
                        arguments: currentData['images']);
                  },
                  onTapEmi: () {
                    Navigator.pushNamed(context, RouteName.emi,
                        arguments: int.parse(currentData['price']));
                  },
                  onTapDocuments: () {
                    Navigator.pushNamed(context, RouteName.documents,
                        arguments: [
                          currentData['docs'],
                          currentData['docNames']
                        ]);
                  },
                  onTapTour: () {
                    Navigator.pushNamed(context, RouteName.tour, arguments: [
                      currentData['videos'],
                      currentData['videoNames']
                    ]);
                  });
            },
          ),
        ])));
  }
}

class RealtorPage extends StatelessWidget {
  final String image;
  final void Function() onTapChat;
  final void Function() onTapLocation;
  final void Function() onTapGallery;
  final void Function() onTapEmi;
  final void Function() onTapDocuments;
  final void Function() onTapTour;
  final void Function() onTapInterested;

  RealtorPage(
      {required this.image,
      required this.onTapChat,
      required this.onTapLocation,
      required this.onTapGallery,
      required this.onTapEmi,
      required this.onTapDocuments,
      required this.onTapTour,
      required this.onTapInterested,
      Key? key})
      : super(key: key);
  final textList = [
    '20% Construction & 80% space',
    'Total 750 flat in 3 towers',
    'Exclusive club house',
    'Just 2kms distance to ORR',
    'Golf track and playground'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_backspace_sharp,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        LayoutBuilder(
          builder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30),
                width: constraints.maxWidth * 0.7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: (constraints.maxWidth * 0.7) - 50,
                          height: 210,
                          child: CachedNetworkImage(
                              imageUrl: image, fit: BoxFit.fill)),
                      const SizedBox(height: 60),
                      const InfoText(text1: 'Type :', text2: 'Shop'),
                      const SizedBox(height: 20),
                      const InfoText(
                          text1: 'Price :', text2: '1500000', isIcon: true),
                      const SizedBox(height: 20),
                      const InfoText(
                          text1: 'Location :', text2: 'LB nagar,Hyd'),
                      const SizedBox(height: 20),
                      const InfoText(text1: 'Possession :', text2: '...'),
                    ]),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onTapLocation,
                        child: const IconWithText(
                            text: "location", image: 'assets/location.png'),
                      ),
                      GestureDetector(
                        onTap: onTapGallery,
                        child: const IconWithText(
                            text: "gallery", image: 'assets/img_preview.png'),
                      ),
                      GestureDetector(
                        onTap: onTapTour,
                        child: const IconWithText(
                            text: "tour", image: 'assets/compass.png'),
                      ),
                      GestureDetector(
                        onTap: onTapDocuments,
                        child: const IconWithText(
                            text: "documents", image: 'assets/documents.png'),
                      ),
                      GestureDetector(
                        onTap: onTapEmi,
                        child: const IconWithText(
                            text: "emi", image: 'assets/credit_card.png'),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const IconWithText(
                            text: "agent", image: 'assets/agent.png'),
                      ),
                    ]),
              ),
            ],
          ),
        )
      ]),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
          child: Row(children: [
            CustomButton(
                    text: 'chat_black',
                    onClick: onTapChat,
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    isNeu: false,
                    color: Colors.white)
                .use(),
            const SizedBox(width: 10),
            Flexible(
                child: CustomButton(
                        text: "I'm Interested",
                        textColor: Colors.black,
                        onClick: onTapInterested,
                        isNeu: false,
                        width: double.maxFinite,
                        height: 40,
                        color: const Color(0xFF2AB0E4))
                    .use()),
            const SizedBox(width: 10),
            CustomButton(
                    text: 'call',
                    onClick: () {},
                    height: 40,
                    width: 40,
                    isIcon: true,
                    rounded: true,
                    isNeu: false,
                    color: Colors.white)
                .use(),
          ]),
        ),
      ),
    ]);
  }
}

class IconWithText extends StatelessWidget {
  final String text;
  final String image;

  const IconWithText({required this.text, required this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
        child: Image.asset(image),
      ),
      const SizedBox(height: 5),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: -0.15,
            color: Colors.white),
      ),
      const SizedBox(height: 15),
    ]);
  }
}

class TextWithIndicator extends StatelessWidget {
  final String text;

  const TextWithIndicator({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.circle_sharp, size: 7, color: Colors.white.withOpacity(0.7)),
      const SizedBox(width: 10),
      Text(text,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white.withOpacity(0.7))),
    ]);
  }
}

class InfoText extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isIcon;
  const InfoText(
      {required this.text1, required this.text2, this.isIcon = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text1,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: -0.15,
                color: Colors.white.withOpacity(0.87)),
          ),
        ),
        Expanded(
          child: Row(children: [
            if (isIcon)
              const Icon(
                Icons.currency_rupee,
                size: 17,
                color: Color(0xFF2AB0E4),
              ),
            Text(
              text2,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.15,
                  color: Colors.white.withOpacity(0.8)),
            ),
          ]),
        )
      ],
    );
  }
}
