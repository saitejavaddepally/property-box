import 'package:flutter/material.dart';

import '../theme/colors.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset('assets/gallery_img_1.png'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset('assets/gallery_img_2.png'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset('assets/gallery_img_3.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
