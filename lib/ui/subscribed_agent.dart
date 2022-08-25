import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/custom_title.dart';
import 'package:property_box/provider/firestore_data_provider.dart';

import '../components/custom_button.dart';
import '../components/custom_container_text.dart';
import '../theme/colors.dart';

class SubscribedAgent extends StatefulWidget {
  final List users;
  const SubscribedAgent({required this.users, Key? key}) : super(key: key);

  @override
  State<SubscribedAgent> createState() => _SubscribedAgentState();
}

class _SubscribedAgentState extends State<SubscribedAgent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                          text: "close_round",
                          onClick: () {
                            Navigator.pop(context);
                          },
                          isIcon: true,
                          height: 40,
                          width: 40,
                          color: HexColor('FD7E0E'),
                          rounded: true)
                      .use(),
                ],
              ),
              const SizedBox(height: 15),
              FutureBuilder<List<Map<String, dynamic>>>(
                initialData: const [],
                future: FirestoreDataProvider.getSubscribedUser(widget.users),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final currentItem = snapshot.data![index];
                              return Neumorphic(
                                margin: const EdgeInsets.only(bottom: 20),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(17)),
                                  depth: 4,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(17.0),
                                                  topRight:
                                                      Radius.circular(17.0),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: 100,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 10,
                                                            right: 10),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Container(
                                                              color:
                                                                  Colors.black,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    currentItem[
                                                                        'profile_pic'],
                                                                errorWidget: (_,
                                                                        __,
                                                                        ___) =>
                                                                    const Icon(Icons
                                                                        .perm_identity),
                                                              ),
                                                            )),
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            0, 18, 0, 18),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Column(
                                                            children: [
                                                              CustomContainerText(
                                                                      text1:
                                                                          'Name',
                                                                      text2: currentItem[
                                                                          'name'])
                                                                  .use(),
                                                              CustomContainerText(
                                                                      text1:
                                                                          'Contact',
                                                                      text2: currentItem[
                                                                          'phone'])
                                                                  .use(),
                                                              CustomContainerText(
                                                                      text1:
                                                                          'Location',
                                                                      text2: currentItem[
                                                                          'location'])
                                                                  .use(),
                                                              CustomContainerText(
                                                                      text1:
                                                                          'Distance',
                                                                      text2: '')
                                                                  .use(),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 6, 12, 6),
                                              decoration: BoxDecoration(
                                                color: CustomColors.dark,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(17.0),
                                                  bottomRight:
                                                      Radius.circular(17.0),
                                                ),
                                                // border: Border.all()
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CircleButton(
                                                      onTap: () {},
                                                      iconData: Image.asset(
                                                        'assets/chat_icon.png',
                                                      )),
                                                  const SizedBox(width: 12),
                                                  CircleButton(
                                                      onTap: () => {},
                                                      iconData: Image.asset(
                                                        'assets/call_3.png',
                                                      )),
                                                ],
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Center(
                          child: CustomTitle(text: 'No Agent Subscribe Yet!'));
                    }
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: CustomTitle(text: 'Something Went Wrong'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Image iconData;
  final Color color;

  const CircleButton(
      {Key? key,
      required this.onTap,
      required this.iconData,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
