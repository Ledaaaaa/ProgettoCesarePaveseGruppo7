import 'package:flutter/material.dart';
import 'package:progetto_cesare_pavese/pages/4_quiz_screen.dart';
import 'package:progetto_cesare_pavese/themes/strings.dart';

import '../themes/colors.dart';

class PreQuizScreen extends StatelessWidget {
  const PreQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Image.asset('assets/images/image_quiz.png', width: deviceWidth),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Text(
                      titleAQuiz,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      sTitleAQuiz,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttonPreQColorCP),
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.only(
                                  left: 120,
                                  right: 120,
                                  top: 10,
                                  bottom: 10,
                                )),
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionPage()));
                        },
                        child: const Text("Inizia",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white)))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
