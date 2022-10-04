import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../provider/firestore_data_provider.dart';
import '../../../route_generator.dart';
import '../../../theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class People extends StatefulWidget {
  const People({Key? key}) : super(key: key);

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomColors.dark,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                unselectedLabelColor: HexColor("#b48484"),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(fontSize: 27),
                indicator: MaterialIndicator(
                  height: 4,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 5,
                  color: HexColor('FE7F0E'),
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      "Customers",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "AgentFly",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Customers(),
            Container(),
          ],
        ),
      ),
    );
  }
}

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  Future<void> callChatScreen(
      BuildContext context, String name, String uid) async {
    await Navigator.pushNamed(context, RouteName.chatDetail,
        arguments: [uid, name]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                final currentItem = snapshot.data?.docs[index].data();
                return FutureBuilder<num>(
                  initialData: 0,
                  future: FirestoreDataProvider()
                      .getParticularChatCounter(currentItem?['uid']),
                  builder: (context, snapshot1) => FutureBuilder<List>(
                      future: FirestoreDataProvider()
                          .getLatestMessage(currentItem?['uid']),
                      initialData: const [null, ''],
                      builder: (context, snapshot2) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                          snapshot2.data?[1].toString() ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis)),
                                  if (snapshot1.data != 0)
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 1.5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(snapshot1.data.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12))),
                                ]),
                            onTap: () => callChatScreen(context,
                                currentItem?['name'], currentItem?['uid']),
                            leading: CircleAvatar(
                              radius: 25,
                              child: CachedNetworkImage(
                                  imageUrl: currentItem?['profile_pic'],
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.perm_identity)),
                            ),
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text("${currentItem?['name']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18)),
                                  ),
                                  Text(formatTimestamp(snapshot2.data?[0]),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                ]),
                          ),
                        );
                      }),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Something Went Wrong'));
          }
        });
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final dateToCheck =
          DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
      final aDate =
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
      if (aDate == today) {
        var format = DateFormat('h:mm:a'); // <- use skeleton here
        return format.format(timestamp.toDate());
      } else if (aDate == yesterday) {
        return "Yesterday";
      } else {
        var format = DateFormat('d-MM-y'); // <- use skeleton here
        return format.format(timestamp.toDate());
      }
    }
    return '';
  }
}
