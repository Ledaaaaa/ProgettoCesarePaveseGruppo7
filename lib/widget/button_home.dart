import 'package:flutter/material.dart';

class MyButtonHome extends StatelessWidget {
  const MyButtonHome({super.key, required this.image, required this.page});

  final String image;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: MaterialButton(
        elevation: 8.0,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
            width: 380,
            height: 95),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}
