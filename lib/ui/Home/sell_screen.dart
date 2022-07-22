import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/custom_neu_text_field.dart';
import 'package:property_box/provider/sell_provider.dart';
import 'package:property_box/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../components/custom_neu_selector.dart';
import '../../components/custom_title.dart';
import '../../components/neu_circular_button.dart';
import '../../provider/firestore_data_provider.dart';
import '../../theme/colors.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  var data1 = {
    {'img': 'sell_1', 'name': 'Lands'},
    {'img': 'sell_2', 'name': 'Offices'},
    {'img': 'sell_3', 'name': 'Plots'},
    {'img': 'sell_4', 'name': 'Flats'},
  };
  var data2 = {
    {'img': 'sell_5', 'name': 'Shops'},
    {'img': 'sell_6', 'name': 'Villas'},
    {'img': 'sell_8', 'name': 'Rental homes'},
    {'img': 'sell_7', 'name': 'All'},
  };

  int counter = 0;
  List<String> profileImages = [];
  Map profileImagesSorted = {};

  String numberOfProperties = "Loading .. ";
  bool loading = false;
  List plotPagesInformationOriginal = [];
  List plotPagesInformation = [];
  int page = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();

    //getPlotInformation();
  }

  // Future getPlotInformation() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   String? userId = await SharedPreferencesHelper().getUserId();
  //   List numberOfProperties = await FirestoreDataProvider().getPlots();
  //   int number = int.parse(numberOfProperties.length.toString());

  //   for (var i = 0; i < number; i++) {
  //     String plot = numberOfProperties[i] as String;
  //     var plotNumber = plot.substring(5);
  //     print("the plot is $plotNumber");
  //     List detailsOfPages = await FirestoreDataProvider()
  //         .getPlotPagesInformation(int.parse(plotNumber));

  //     if (detailsOfPages.isEmpty) {
  //       continue;
  //     }

  //     String profilePicture = await FirestoreDataProvider().getProfileImage(
  //         "sell_images/$userId/standlone/plot_$plotNumber/images/");
  //     profileImagesSorted.putIfAbsent(i, () => profilePicture);
  //     detailsOfPages.add({"plotNo": plotNumber});
  //     detailsOfPages.add({"picture": profilePicture});
  //     plotPagesInformationOriginal.add(detailsOfPages);
  //   }
  //   setState(() {
  //     plotPagesInformation = plotPagesInformationOriginal;
  //     this.numberOfProperties = plotPagesInformation.length.toString();
  //     loading = false;
  //   });

  //   return plotPagesInformation;
  // }

  // filterPlotsBasedOnTypes(String type) {
  //   List filteredList = plotPagesInformationOriginal
  //       .where((element) => element[0]['propertyType'] == type)
  //       .toList();
  //   setState(() {
  //     plotPagesInformation = filteredList;
  //     numberOfProperties = plotPagesInformation.length.toString();
  //   });
  // }

  // sortPlotsBasedOnTypes(String type) {
  //   //price low to high
  //   if (type == "Price High - Low ") {
  //     plotPagesInformation.sort((a, b) =>
  //         int.parse(b[0]['price']).compareTo(int.parse(a[0]['price'])));
  //     setState(() {
  //       plotPagesInformation;
  //     });
  //   }
  //   // price high to low
  //   else if (type == "Price Low - High") {
  //     print("Am I here?");
  //     plotPagesInformation.sort((a, b) =>
  //         int.parse(a[0]['price']).compareTo(int.parse(b[0]['price'])));
  //     setState(() {
  //       // plotPagesInformation = plotPagesInformation.reversed.toList();
  //     });
  //   } else if (type == "Date - Recent First") {
  //     plotPagesInformation.sort((a, b) => DateTime.parse(a[0]['timestamp'])
  //         .compareTo(DateTime.parse(b[0]['timestamp'])));
  //     setState(() {
  //       // plotPagesInformation = plotPagesInformation.reversed.toList();
  //     });
  //   } else {
  //     plotPagesInformation.sort((a, b) => DateTime.parse(b[0]['timestamp'])
  //         .compareTo(DateTime.parse(a[0]['timestamp'])));
  //     setState(() {
  //       // plotPagesInformation = plotPagesInformation.reversed.toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SellScreenProvider(),
        builder: (context, child) {
          final _spr = Provider.of<SellScreenProvider>(context, listen: false);
          return Scaffold(
              backgroundColor: CustomColors.dark,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<SellScreenProvider>(
                                  builder: (context, value, child) => Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: DropdownButton<String>(
                                        dropdownColor: CustomColors.dark,
                                        underline: const SizedBox(),
                                        items: value.currentLocationDropDown
                                            .map((e) =>
                                                DropdownMenuItem<String>(
                                                    child: Text(e,
                                                        style: const TextStyle(
                                                            color: null)),
                                                    value: e))
                                            .toList(),
                                        value: value.currentLocationChosenValue,
                                        iconEnabledColor:
                                            const Color(0xFF2AB0E4),
                                        iconDisabledColor:
                                            const Color(0xFF2AB0E4),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        onChanged:
                                            value.onChangedCurrentLocation,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(children: [
                                  Container(
                                    child: CircularNeumorphicButton(
                                            imageName: 'img_2',
                                            padding: 0,
                                            color: CustomColors.dark,
                                            size: 50,
                                            onTap: () {},
                                            isNeu: true,
                                            isTextUnder: true,
                                            text: 'Add')
                                        .use(),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    child: CircularNeumorphicButton(
                                            imageName: 'save',
                                            size: 50,
                                            onTap: () {},
                                            color: CustomColors.dark,
                                            isNeu: true,
                                            isTextUnder: true,
                                            text: 'Saved')
                                        .use(),
                                  ),
                                ]),
                              ],
                            )),
                        CustomNeumorphicTextField(
                          borderradius: 30,
                          readOnly: true,
                          fillColor: Colors.white.withOpacity(0.05),
                          hint: (loading)
                              ? 'Loading your properties.. Please wait...'
                              : 'Search by location, Name or ID',
                          icon: Image.asset('assets/search_settings_icon.png',
                              height: 35, width: 30),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Choose property category",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.15,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        Row(
                          children: [
                            for (var element in data1)
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: CircularNeumorphicButton(
                                          imageName: element['img'].toString(),
                                          size: 55,
                                          onTap: () {
                                            String name =
                                                element['name'].toString();
                                            var length = name.length;
                                            // filterPlotsBasedOnTypes(
                                            //     name.substring(0, length - 1));
                                          },
                                          isTextUnder: true,
                                          text: element['name'].toString())
                                      .use(),
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            for (var element in data2)
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: CircularNeumorphicButton(
                                          imageName: element['img'].toString(),
                                          size: 55,
                                          onTap: () {
                                            String name =
                                                element['name'].toString();
                                            var length = name.length;
                                            // filterPlotsBasedOnTypes(
                                            //     name.substring(0, length - 1));
                                          },
                                          isTextUnder: true,
                                          text: element['name'].toString())
                                      .use(),
                                ),
                              ),
                          ],
                        ),
                        Consumer<SellScreenProvider>(
                          builder: (context, value, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: CustomNeuSelector(
                                        dropDownItems: value.possessionDropDown,
                                        onChanged: value.onChangedPossession,
                                        color: CustomColors.dark,
                                        textColor:
                                            Colors.white.withOpacity(0.8),
                                        chosenValue:
                                            value.possessionChosenValue)
                                    .use(),
                              ),
                              const Spacer(flex: 1),
                              Flexible(
                                flex: 2,
                                child: CustomNeuSelector(
                                        dropDownItems: value.sortDropDown,
                                        onChanged: value.onChangedSort,
                                        isPrefixIcon: true,
                                        prefixIcon: Image.asset(
                                            'assets/sort.png',
                                            height: 15,
                                            width: 10),
                                        textColor:
                                            Colors.white.withOpacity(0.8),
                                        color: CustomColors.dark,
                                        chosenValue: value.sortChosenValue)
                                    .use(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        FutureBuilder<List>(
                            future: FirestoreDataProvider().getAllProperties(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  final data = snapshot.data;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data!.length} properties found for you",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: data.length,
                                          itemBuilder: (context, index) {
                                            final currentData = data[index];
                                            final imageList =
                                                currentData['images'];
                                            final propertyType =
                                                currentData['propertyType'] ??
                                                    '';
                                            final size =
                                                currentData['size'] ?? '';
                                            final price =
                                                currentData['price'] ?? '';
                                            final location =
                                                currentData['location'] ?? '';
                                            return ChangeNotifierProvider(
                                                create: (context) =>
                                                    PageNumberProvider(),
                                                builder: (context, child) {
                                                  final pr = Provider.of<
                                                          PageNumberProvider>(
                                                      context,
                                                      listen: false);
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child: Neumorphic(
                                                      style: NeumorphicStyle(
                                                          color:
                                                              CustomColors.dark,
                                                          shadowLightColor:
                                                              Colors.black,
                                                          depth: 10,
                                                          intensity: 0.5,
                                                          lightSource:
                                                              LightSource
                                                                  .topLeft,
                                                          shape: NeumorphicShape
                                                              .flat,
                                                          boxShape:
                                                              NeumorphicBoxShape
                                                                  .roundRect(
                                                            BorderRadius
                                                                .circular(10),
                                                          )),
                                                      child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: const Color(
                                                                0xFF1C1C1C),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 160,
                                                                width: double
                                                                    .maxFinite,
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10))),
                                                                child: Stack(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              RouteName.realtorCard,
                                                                              arguments: {
                                                                                'data': data,
                                                                                'index': index
                                                                              });
                                                                        },
                                                                        child: CarouselSlider
                                                                            .builder(
                                                                          carouselController:
                                                                              _carouselController,
                                                                          itemCount:
                                                                              imageList.length,
                                                                          itemBuilder: (BuildContext context,
                                                                              int itemIndex,
                                                                              int pageViewIndex) {
                                                                            return SizedBox(
                                                                              height: 160,
                                                                              width: double.maxFinite,
                                                                              child: CachedNetworkImage(imageUrl: imageList[itemIndex], fit: BoxFit.fill),
                                                                            );
                                                                          },
                                                                          options:
                                                                              CarouselOptions(
                                                                            height:
                                                                                160,
                                                                            autoPlayCurve:
                                                                                Curves.easeIn,
                                                                            viewportFraction:
                                                                                1,
                                                                            enableInfiniteScroll:
                                                                                false,
                                                                            onPageChanged:
                                                                                pr.onPageNumberChanged,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.bottomCenter,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.only(
                                                                              bottom: 10,
                                                                              left: (MediaQuery.of(context).size.width / 2) - 48),
                                                                          child:
                                                                              Consumer<PageNumberProvider>(
                                                                            builder: (context, value, child) =>
                                                                                Row(
                                                                              children: [
                                                                                for (int i = 0; i < imageList.length; i++) (value.page == i) ? activeIndicator() : inactiveIndicator()
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            _carouselController.previousPage(curve: Curves.easeIn);
                                                                          },
                                                                          child: Container(
                                                                              margin: const EdgeInsets.only(left: 5),
                                                                              padding: const EdgeInsets.all(2),
                                                                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(15)),
                                                                              child: const Icon(Icons.keyboard_arrow_left_rounded, color: Color(0xFF2AB0E4), size: 22)),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            _carouselController.nextPage(curve: Curves.easeIn);
                                                                          },
                                                                          child: Container(
                                                                              margin: const EdgeInsets.only(right: 5),
                                                                              padding: const EdgeInsets.all(2),
                                                                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(15)),
                                                                              child: const Icon(Icons.keyboard_arrow_right_rounded, color: Color(0xFF2AB0E4), size: 22)),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child: Container(
                                                                            margin: const EdgeInsets.only(right: 5, top: 5),
                                                                            padding: const EdgeInsets.all(4),
                                                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(30)),
                                                                            child: const Icon(
                                                                              Icons.favorite_border,
                                                                              color: Colors.white,
                                                                              size: 25,
                                                                            )),
                                                                      )
                                                                    ]),
                                                              ),
                                                              const SizedBox(
                                                                  height: 15),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                    "${propertyType ?? ''} ( $size )",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            -0.15)),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Row(
                                                                          children: [
                                                                            const Icon(Icons.location_on,
                                                                                color: Colors.white,
                                                                                size: 17),
                                                                            Flexible(
                                                                              child: Text(
                                                                                location,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: -0.15, color: Colors.white),
                                                                              ),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons
                                                                                .currency_rupee_rounded,
                                                                            color:
                                                                                Color(0xFF2AB0E4),
                                                                            size: 17),
                                                                        Text(
                                                                          price,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14,
                                                                              letterSpacing: -0.15,
                                                                              color: Colors.white),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                            ],
                                                          )),
                                                    ),
                                                  );
                                                });
                                          })
                                    ],
                                  );
                                } else {
                                  return const CustomTitle(
                                      text: "No properties found");
                                }
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: CustomTitle(
                                        text: 'Something Went Wrong'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget inactiveIndicator() {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFFFFFFFF).withOpacity(0.54)),
    );
  }

  Widget activeIndicator() {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFF2AB0E4).withOpacity(0.54)),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Image iconData;

  const CircleButton({Key? key, required this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
