import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../helper/contants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../theme/colors.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded,
                      color: Colors.white)),
              GestureDetector(
                  onTap: () {}, child: Image.asset('assets/notific.png'))
            ]),
            const SizedBox(height: 30),
            Flexible(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Neumorphic(
                            padding: EdgeInsets.all(7),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                color: CustomColors.dark,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                shadowLightColor: Colors.black),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor('1C1C1C'),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SfPdfViewer.network(
                                                  'https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf',
                                                  canShowPaginationDialog: true,
                                                  canShowScrollHead: true,
                                                  canShowPasswordDialog: true,
                                                  canShowScrollStatus: true,
                                                  enableDoubleTapZooming: true,
                                                  onDocumentLoadFailed:
                                                      (details) {
                                                    print(details.error);
                                                  },
                                                )));
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  horizontalTitleGap: 10,
                                  leading:
                                      Image.asset('assets/document_image.png'),
                                  title: Text(
                                    'verified',
                                    style: TextStyle(
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        letterSpacing: -0.15,
                                        color: CustomColors.lightBlue),
                                  ),
                                  subtitle: const Text(
                                    'Floor plans with setback',
                                    style: TextStyle(
                                        height: 1.3,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: -0.15,
                                        color: Colors.white),
                                  ),
                                  trailing: (isChecked)
                                      ? Image.asset('assets/checked.png')
                                      : Image.asset('assets/unchecked.png')),
                            ),
                          ),
                        )))
          ]),
        )));
  }
}
