import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:readmore/readmore.dart';

import '../components/custom_button.dart';
import '../components/neu_circular_button.dart';
import '../route_generator.dart';
import '../theme/colors.dart';
import 'Home/projects.dart';

class ProjectExplorer extends StatefulWidget {
  final Map projectDetails;
  const ProjectExplorer({Key? key, required this.projectDetails})
      : super(key: key);

  @override
  State<ProjectExplorer> createState() => _ProjectExplorerState();
}

class _ProjectExplorerState extends State<ProjectExplorer> {
  late Map data;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    data = widget.projectDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded)),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                  child: CustomImage(
                    height: 200,
                    onTap: () {},
                    image: data['images'][0],
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              color: HexColor('F14B4B'),
                              borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 5),
                      Text('Venture Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.7)))
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: -0.14,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: 'Price'),
                              TextSpan(
                                  text: ' : 5500 - 6000 Sq.yd',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)))
                            ])),
                        const SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: -0.14,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: 'Plot sale'),
                              TextSpan(
                                  text: ' : 1100 - 2600 Sq.yd',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)))
                            ]))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                'Sunshine park is HMDA approved layout situated at yadadri on warangal highway spread across 25 acres woth all amenitess and ready to contact house move',
                trimLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.15,
                    height: 1.3),
                colorClickableText: CustomColors.lightBlue,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: 'less',
              ),
              const SizedBox(height: 25),
              Text(
                'Details',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.15,
                    color: CustomColors.lightBlue),
              ),
              const SizedBox(height: 15),
              Neumorphic(
                padding: const EdgeInsets.all(5),
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    color: CustomColors.dark,
                    shadowLightColor: Colors.white.withOpacity(0.3)),
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor('191E1F')),
                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      autoPlay: false,
                      height: 90,
                    ),
                    items: [
                      Page(
                        controller: buttonCarouselController,
                        pageNumber: 1,
                        projectDetails: data,
                        nameList: const [
                          'Location',
                          'Gallery',
                          'Tour',
                          'Layout'
                        ],
                      ),
                      Page(
                        controller: buttonCarouselController,
                        pageNumber: 2,
                        projectDetails: data,
                        nameList: const [
                          'Layout',
                          'Emi',
                          'Realtor',
                          'Broucher'
                        ],
                      )
                    ].map((page) {
                      return page;
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const CustomText(
                  text1: 'Amenities :',
                  text2: 'Club House, Parks, Temples, Schools, Tennis Court'),
              const SizedBox(height: 15),
              const CustomText(text1: 'Possession :', text2: 'Ready To Occupy'),
              const SizedBox(height: 60),
              Row(children: [
                CustomButton(
                        text: 'chat_black',
                        onClick: () {},
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
                            onClick: () {
                              final Map subscribedUsers =
                                  data['subscribedUsers'] ?? {};
                              Navigator.pushNamed(
                                  context, RouteName.subscribedAgent,
                                  arguments: subscribedUsers.keys.toList());
                            },
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
            ],
          ),
        ),
      )),
    );
  }
}

class Page extends StatelessWidget {
  final CarouselController controller;
  final int pageNumber;

  final List nameList;
  final Map projectDetails;
  const Page(
      {required this.controller,
      required this.pageNumber,
      required this.projectDetails,
      required this.nameList,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pageNumber == 2)
          Row(children: [
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  controller.previousPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 25, color: CustomColors.lightBlue),
                )),
          ]),
        for (String i in nameList)
          Flexible(
            child: CircularNeumorphicButton(
                color: CustomColors.dark,
                isNeu: false,
                imageName: i,
                width: 24,
                text: i,
                isTextUnder: true,
                onTap: () {
                  print(i);
                  switch (i.toLowerCase()) {
                    case 'location':
                      {
                        Navigator.pushNamed(context, RouteName.location,
                            arguments: [
                              projectDetails['latitude'],
                              projectDetails['longitude']
                            ]);
                        break;
                      }

                    case 'gallery':
                      {
                        Navigator.pushNamed(context, RouteName.gallery,
                            arguments: projectDetails['images']);
                        break;
                      }
                    case 'tour':
                      {
                        print(projectDetails['videos']);
                        Navigator.pushNamed(context, RouteName.tour,
                            arguments: projectDetails['videos']);
                        break;
                      }
                  }
                }).use(),
          ),
        if (pageNumber == 1)
          Row(children: [
            GestureDetector(
                onTap: () {
                  controller.nextPage();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 25, color: CustomColors.lightBlue),
                )),
            const SizedBox(width: 10),
          ]),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomText({required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          text1,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: -0.15,
              color: CustomColors.lightBlue),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(text2,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.15,
                  color: Colors.white.withOpacity(0.8))),
        )
      ],
    );
  }
}
