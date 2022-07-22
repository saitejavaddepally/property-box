import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../theme/colors.dart';

class GalleryScreen extends StatefulWidget {
  final List images;
  const GalleryScreen({required this.images, Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Future urlToFile(String imageUrl) async {
    var rng = Random();
    final directory = await getApplicationDocumentsDirectory();
    String tempPath =
        directory.path + '/' + (rng.nextInt(100)).toString() + '.png';
    File file = File(tempPath);
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    OpenFile.open(tempPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 24),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await EasyLoading.show(
                            indicator: const Text('Please Wait...',
                                style: TextStyle(color: Colors.white)),
                            maskType: EasyLoadingMaskType.black);
                        await urlToFile(widget.images[index]);
                        await EasyLoading.dismiss();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    widget.images[index],
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white)),
                    );
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
