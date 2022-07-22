import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../provider/firestore_data_provider.dart';
import '../../../route_generator.dart';
import '../../../theme/colors.dart';
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
                  builder: (context, snapshot) => FutureBuilder<String>(
                    future: FirestoreDataProvider()
                        .getLatestMessage(currentItem?['uid']),
                    initialData: '',
                    builder: (context, snapshot1) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.7)),
                      child: ListTile(
                        subtitle: Text(snapshot1.data.toString()),
                        onTap: () => callChatScreen(
                            context, currentItem?['name'], currentItem?['uid']),
                        leading: CircleAvatar(
                            child: Image.asset("assets/profile.png")),
                        trailing: (snapshot.data == 0)
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(snapshot.data.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16))),
                        title: Text(
                            "${currentItem?['name']} (${currentItem?['phone']})"),
                      ),
                    ),
                  ),
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
}
