import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

import '../../../components/custom_text_field.dart';
import '../../../components/neu_circular_button.dart';
import '../../../services/loction_service.dart';
import '../../../theme/colors.dart';

class ChatDetail extends StatefulWidget {
  final String friendUid;
  final String friendName;

  const ChatDetail({
    Key? key,
    required this.friendUid,
    required this.friendName,
  }) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  final _textController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<String> createOrGetChatDocId() async {
    try {
      final querySnapshot = await chats
          .where('users',
              isEqualTo: {widget.friendUid: null, currentUserId: null})
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.single.id;
      } else {
        final docRef = await chats.add({
          'users': {currentUserId: null, widget.friendUid: null}
        });
        return docRef.id;
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future openDocument(Map data) async {
    if (data['type'] == 'pdf') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Container(
                    color: CustomColors.dark,
                    child: SfPdfViewer.network(
                      data['msg'],
                    ),
                  )));
    } else {
      final Uri _url = Uri.parse(data['msg']);
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $_url';
      }
    }
  }

  // @override
  // void initState() {
  //   chats
  //       .where('users',
  //           isEqualTo: {widget.friendUid: null, currentUserId: null})
  //       .limit(1)
  //       .get()
  //       .then((QuerySnapshot<Object?> snapshot) {
  //         if (snapshot.docs.isNotEmpty) {
  //           chatDocId = snapshot.docs.single.id;
  //           setState(() {});
  //         } else {
  //           chats.add({
  //             'users': {currentUserId: null, widget.friendUid: null}
  //           }).then((value) {
  //             // print(value);

  //             chatDocId = value.toString();
  //             //setState(() {});
  //           });
  //         }
  //       })
  //       .catchError((error) {});
  //   super.initState();
  // }

  void sendMessage(String message, String chatDocId,
      {String type = 'text', String fileName = ''}) {
    if (message.trim().isEmpty) return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': message,
      'fileName': fileName,
      'type': type,
    }).then((value) {
      _textController.text = '';
    });
  }

  Future pickImage(String chatDocId, BuildContext contest) async {
    Navigator.pop(context);
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image == null) return;
    final imageFile = File(image.path);
    await uploadFile(chatDocId, imageFile, 'image', image.path);
  }

  Future pickFile(String chatDocId, BuildContext context) async {
    Navigator.pop(context);
    final result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    if (result == null) return;
    final platformfile = result.files.first;
    File pickFile = File(platformfile.path!);
    String fileName = platformfile.name;
    await uploadFile(chatDocId, pickFile, 'pdf', fileName);
  }

  Future uploadFile(
      String chatDocId, File file, String type, String name) async {
    String fileName = const Uuid().v1();
    final ref = FirebaseStorage.instance
        .ref()
        .child('chat_files')
        .child('$fileName.jpg');
    final uploadTask = await ref.putFile(file);
    final fileUrl = await uploadTask.ref.getDownloadURL();
    sendMessage(fileUrl, chatDocId, type: type, fileName: name);
  }

  void sendLocation(String chatDocId, double lat, double long) {
    chats
        .doc(chatDocId)
        .collection('messages')
        .add({
          'createdOn': FieldValue.serverTimestamp(),
          'uid': currentUserId,
          'lat': lat,
          'long': long,
          'type': "loc",
        })
        .then((value) {})
        .catchError((error) {
          print(error);
        });
  }

  void getLocation(String chatDocId) {
    GetUserLocation().determinePosition().then((value) {
      sendLocation(chatDocId, value.latitude, value.longitude);
    }).catchError((error) {
      if (error == 'Location services are disabled.') {
        Fluttertoast.showToast(
            msg: "Please open location first.", toastLength: Toast.LENGTH_LONG);
      } else if (error == 'Location permissions are denied') {
        Fluttertoast.showToast(
            msg: "You Don't send location without allow location permission",
            toastLength: Toast.LENGTH_LONG);
      } else if (error ==
          'Location permissions are permanently denied, we cannot request permissions.') {
        Fluttertoast.showToast(
            msg:
                "Sorry We can't help you because you didn't allow location permission",
            toastLength: Toast.LENGTH_LONG);
      } else {
        print(error);
      }
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: createOrGetChatDocId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatDocId = snapshot.data!;
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatDocId)
                    .collection('messages')
                    .orderBy('createdOn', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final list = snapshot.data!.docs;
                    return Scaffold(
                      key: _scaffoldKey,
                      body: SafeArea(
                          child: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: list.length,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    Map data = list[index].data();

                                    return SizedBox(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ChatBubble(
                                            clipper: ChatBubbleClipper6(
                                              nipSize: 0,
                                              radius: 20,
                                              type: isSender(
                                                      data['uid'].toString())
                                                  ? BubbleType.sendBubble
                                                  : BubbleType.receiverBubble,
                                            ),
                                            alignment: getAlignment(
                                                data['uid'].toString()),
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            backGroundColor:
                                                isSender(data['uid'].toString())
                                                    ? const Color(0xFF08C187)
                                                    : const Color(0xffE7E7ED),
                                            child: data['type'] == 'text'
                                                ? Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(data['msg'],
                                                                style: TextStyle(
                                                                    color: isSender(data['uid']
                                                                            .toString())
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                                maxLines: 100,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              data['createdOn'] ==
                                                                      null
                                                                  ? DateTime
                                                                          .now()
                                                                      .toString()
                                                                  : data['createdOn']
                                                                      .toDate()
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: isSender(
                                                                          data['uid']
                                                                              .toString())
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : (data['type'] == 'loc')
                                                    ? SizedBox(
                                                        height: 250,
                                                        width: 180,
                                                        child: GoogleMap(
                                                          markers: {
                                                            Marker(
                                                                markerId: MarkerId(LatLng(
                                                                        data[
                                                                            'lat'],
                                                                        data[
                                                                            'long'])
                                                                    .toString()),
                                                                position: LatLng(
                                                                    data['lat'],
                                                                    data[
                                                                        'long']))
                                                          },
                                                          onMapCreated:
                                                              _onMapCreated,
                                                          initialCameraPosition:
                                                              CameraPosition(
                                                            target: LatLng(
                                                                data['lat'],
                                                                data['long']),
                                                            zoom: 11.0,
                                                          ),
                                                        ))
                                                    : GestureDetector(
                                                        onTap: () async {
                                                          await openDocument(
                                                              data);
                                                        },
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 150,
                                                          child: FittedBox(
                                                              fit: BoxFit.fill,
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                        text: data['type'].toString().toUpperCase() +
                                                                            " File\n"),
                                                                    const TextSpan(
                                                                        text:
                                                                            "Tap to Open",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                5))
                                                                  ]))),
                                                        ),
                                                      )),
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: CustomTextField(
                                    controller: _textController,
                                    icon: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) {
                                                return customBottomSheet(
                                                    chatDocId);
                                              });
                                        },
                                        child: const Icon(
                                            Icons.animation_rounded)),
                                  )),
                                  TextButton(
                                      child: const Icon(Icons.send_sharp),
                                      onPressed: () => sendMessage(
                                          _textController.text, chatDocId))
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('Something Went Wrong'));
                  }
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Something Went Wrong"));
          }
        });
  }

  Widget customBottomSheet(String chatDocId) {
    return Container(
        decoration: BoxDecoration(
            color: CustomColors.dark, borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CircularNeumorphicButton(
                  imageName: "Location",
                  onTap: () {
                    getLocation(chatDocId);
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  isNeu: false,
                  isTextUnder: true,
                  text: "Location")
              .use(),
          CircularNeumorphicButton(
                  imageName: "documents",
                  onTap: () async {
                    await pickFile(chatDocId, context);
                  },
                  color: Colors.brown,
                  isNeu: false,
                  isTextUnder: true,
                  text: "Documments")
              .use(),
          CircularNeumorphicButton(
                  imageName: "Gallery",
                  onTap: () async {
                    await pickImage(chatDocId, context);
                  },
                  color: Colors.brown,
                  isNeu: false,
                  isTextUnder: true,
                  text: "Gallery")
              .use()
        ]));
  }
}
