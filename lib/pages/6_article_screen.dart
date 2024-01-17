import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key,
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.title, required this.data, required this.ora, required this.luogo});

  final String image;
  final String text1;
  final String text2;
  final String text3;
  final String title;
  final String data;
  final String ora;
  final String luogo;


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xFFF5F5F5),
              ),
              /*Container(
                width: deviceWidth,
                height: deviceWidth *
                    0.5, // Puoi regolare il rapporto altezza/larghezza come desideri
                decoration: const ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://fondazionecesarepavese.it/wp-content/uploads/2022/09/GruppoLettura2023-2024.png"),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),*/
              Image.asset(
                image,
                width: deviceWidth,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16.0),
               Center(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Allinea i children in alto lungo l'asse principale (verticale)
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(width: 10.0),
                              Text(
                                data,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const Icon(Icons.access_time_outlined),
                              const SizedBox(width: 10.0),
                              Text(
                                ora,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          width: 40.0), // Aggiungi uno spazio tra le due righe
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Allinea i children in alto lungo l'asse principale (verticale)
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.map),
                              const SizedBox(width: 10.0),
                              Text(
                                luogo,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Row(
                            children: [
                              Icon(Icons.money),
                              SizedBox(width: 10.0),
                              Text(
                                'Gratuito',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      text1,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      text3,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
