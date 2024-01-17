import 'package:flutter/material.dart';

import '../themes/colors.dart';

class MyCardHome extends StatelessWidget {
  const MyCardHome(
      {super.key,
      required this.image,
      required this.page,
      required this.text1,
      required this.text2,
      required this.text3});

  final String image;
  final String text1;
  final String text2;
  final String text3;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image),
              const SizedBox(height: 10),
              Text(text1,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: primaryColorCP)),
              Text(text2,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(text3,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))
            ],
          )),
    );
  }
}
