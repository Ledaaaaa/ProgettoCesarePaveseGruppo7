import 'package:flutter/material.dart';

import '../themes/strings.dart';
import '2_home_screen.dart';

class MyStartPage extends StatefulWidget {
  const MyStartPage({Key? key});

  @override
  State<MyStartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          fondCesPav,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'Ciao,',
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' dimmi',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
            const Text('come ti chiami',
              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 36,
                color: Colors.black),),
            SizedBox(
              width: 300,
              child: TextField(

                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Inserisci il tuo nome',
                    border: const OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(30.0))),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Errore'),
                                content: const Text('Inserisci il nome'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Naviga verso la pagina di benvenuto
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(name: nameController.text),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_rounded),
                    )),
                /*labelText: 'Inserisci il tuo nome',
                  labelStyle: TextStyle(fontSize: 18),
                ),*/
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Errore'),
                        content: const Text('Inserisci il nome'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Naviga verso la pagina di benvenuto
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(name: nameController.text),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Accedi', style: TextStyle(fontSize: 20)),
            ),*/
          ],
        ),
      ),
    );
  }
}
