import 'package:flutter/material.dart';

class CustomContainerText {
  late String text1;
  late String text2;

  CustomContainerText({required this.text1, required this.text2});

  use() {
    return SizedBox(
      height: 22,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                    text: text1 + ': ',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: text2,
                    style: const TextStyle(
                      color: Colors.black,
                    )),
              ],
            )),
      ),
    );
  }
}
