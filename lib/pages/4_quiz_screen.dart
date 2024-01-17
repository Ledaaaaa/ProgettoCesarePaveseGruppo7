import 'package:flutter/material.dart';
import 'package:progetto_cesare_pavese/pages/5_result_quiz_screen.dart';
import '../data/questions_data.dart';
import '../themes/colors.dart';
import '../widget/options_quiz.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  String _frase = '';
  bool _isLocked = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Text('$_questionNumber/${questions.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                //const Divider(thickness: 1, color: Colors.green),
                Expanded(
                    child: PageView.builder(
                  itemCount: questions.length,
                  //numero pagina incrementa quando rispondi alle domande
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return buildQuestion(question);
                  },
                )),
                //mostra o nasconde il button se hai risposto o no
                 buildElevatedButton() ,
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: questionColorCP,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 180,
              child: Column(
                children: [
                  Stack(alignment: Alignment.topRight, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        width: 40,
                        height: 55,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/icon_flag.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(child: Text('$_questionNumber', style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: secondaryColorCP))),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ]),
                  ]),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(question.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 0.97,
                              fontSize: 22)),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),
        buildFrase(),
        const SizedBox(height: 16),
        Expanded(
            child: OptionsWidget(
          question: question,
          onClickedOption: (option) {
            if (question.isLocked) {

              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;

              });
              _isLocked = question.isLocked;
              if (question.selectedOption!.isCorrect) {
                _score++;

                _frase = 'Risposta corretta!';
              } else if (!question.selectedOption!.isCorrect) {
                _frase = 'Risposta sbagliata!';

              }
            }
          },
        ))
      ],
    );
  }

  Widget buildFrase() {
    return Center(
      child: _isLocked
          ? Text(
              _frase,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            )
          : const Text(
              'Scegli la risposta corretta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
    );
  }

  Column buildElevatedButton() {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonPreQColorCP),
                padding: MaterialStateProperty.all(const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 10,
                  bottom: 10,
                )),
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 30, color: Colors.white)),
              ),
              onPressed: () {
                if (_questionNumber < questions.length) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInExpo,
                  );

                  setState(() {
                    _questionNumber++;
                    _isLocked = false;
                  });
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(score: _score),
                    ),
                  );
                }
              },
              child: Text(
                  _questionNumber < questions.length
                      ? 'Prossima domanda'
                      : 'Verifica',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white))),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
