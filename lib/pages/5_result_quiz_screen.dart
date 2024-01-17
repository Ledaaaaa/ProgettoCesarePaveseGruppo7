import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../themes/colors.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:30.0, right: 30.0),
              child: Image.asset('assets/images/premio.png', width: deviceWidth),
            ),
            const Text('Congratulazioni!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(
              'Hai totalizzato $score/${questions.length} punti',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonPreQColorCP),
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                    left: 50,
                    right: 50,
                    top: 10,
                    bottom: 10,
                  )),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 30, color: Colors.white)),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); /*
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage(name: '',))
                  );
               */
                },
                child: const Text("Torna indietro",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
