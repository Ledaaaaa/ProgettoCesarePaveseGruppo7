import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cesare_pavese/pages/7_prepuzzle_screen.dart';
import 'package:progetto_cesare_pavese/pages/3_prequiz_screen.dart';
import 'package:progetto_cesare_pavese/themes/colors.dart';
import 'package:progetto_cesare_pavese/themes/strings.dart';
import 'package:progetto_cesare_pavese/widget/sottitle_home.dart';
import '../widget/button_home.dart';
import '../widget/card_home.dart';
import '6_article_screen.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: deviceWidth,
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/logofond.png',
                      height: 50,
                    ),
                  ),
                  const Text(fondCesPav),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: OutlinedButton(
                        onPressed: () {
                          openDialog();
                        },
                        child: const Text(aiuto,
                            style: TextStyle(color: secondaryColorCP))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity),
                    RichText(
                      text: TextSpan(
                          text: ciao,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' ${widget.name},',
                                style: const TextStyle(
                                    fontSize: 36, color: primaryColorCP)),
                          ]),
                    ),
                    const Text(titFondCesPav, style: TextStyle(fontSize: 30)),
                    const SizedBox(height: 25),
                    //primo sottotitolo
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: const TextSpan(
                            text: Gioca,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: cNoi,
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      ),
                    ),
                    const MySotTitleHome(
                        text1: sotTitGioca1,
                        text2: sotTitGioca2,
                        text3: sotTitGioca3),
                    const SizedBox(height: 15),
                    //button giochi
                    MyButtonHome(
                      image: 'assets/images/button_color1.png',
                      page: PrePuzzlePage(),
                    ),
                    const MyButtonHome(
                      image: 'assets/images/button_color2.png',
                      page: PreQuizScreen(),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: const TextSpan(
                            text: titNews,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              TextSpan(
                                  text: titNewsB,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ),
                    const MySotTitleHome(
                        text1: sotTitNews, text2: '', text3: ''),

                    //row articoli
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 260,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            MyCardHome(
                                image: 'assets/images/article1.png',
                                page: ArticleScreen(
                                  image: 'assets/images/article1.png',
                                  text1: aadamText1,
                                  text2: aadamText2,
                                  text3: aadamText3,
                                  title: tit1ArtInt,
                                  data: data1art,
                                  ora: ora1art,
                                  luogo: luogo1art,
                                ),
                                text1: ora1Art,
                                text2: tit1Art,
                                text3: tit1Art2),
                            SizedBox(width: 15),
                            MyCardHome(
                                image: 'assets/images/article2.png',
                                page: ArticleScreen(
                                  image: 'assets/images/article2.png',
                                  text1: bauleText1,
                                  text2: bauleText2,
                                  text3: bauleText3,
                                  title: tit2Art,
                                  data: data2art,
                                  ora: ora2Art2,
                                  luogo: luogo2art,
                                ),
                                text1: ora2Art,
                                text2: tit2Art,
                                text3: ''),
                          ],
                        ))
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: questionColorCP,
          title: const Text(titAlert),
          content: const Text(bodyAlert, style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'X',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
}
