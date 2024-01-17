import 'package:flutter/material.dart';

import '../themes/colors.dart';

class MySotTitleHome extends StatelessWidget {
  const MySotTitleHome({super.key, required this.text1,required this.text2,required this.text3});

  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(
          text: text1,
          style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal),
          children: <TextSpan>[
            TextSpan(
                text: text2,
                style: const TextStyle(
                    color: secondaryColorCP,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: text3,
                style: const TextStyle(fontWeight: FontWeight.normal))
          ]),
    );
  }
  }