import 'package:flutter/material.dart';
import 'package:progetto_cesare_pavese/pages/8_puzzle_screen.dart';
import '../themes/colors.dart';

class PrePuzzlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/image_puzzle.png', width: deviceWidth),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Divertiti a scoprire tante curiosità di Cesare Pavese',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Premi inizia, mischia il puzzle e divertiti a riordinarlo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
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
                              builder: (context) =>  PuzzlePage()));
                    },
                    child: const Text("Inizia",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white))),

                //button per tre livelli di difficoltà
                /*const SizedBox(height: 20),
                _buildLevelSelection(context, 'Facile'),
                const SizedBox(height: 10),
                _buildLevelSelection(context, 'Medio'),
                const SizedBox(height: 10),
                _buildLevelSelection(context, 'Difficile'),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
//widget per tre livelli
 /* Widget _buildLevelSelection(BuildContext context, String level) {
    return GestureDetector(
      onTap: () {
        // Naviga alla pagina del puzzle quando il livello viene selezionato
        if (level == 'Facile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PuzzlePage()),
          );
        }
        // Puoi implementare logiche simili per gli altri livelli se necessario
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white, // Cambiato colore in blu per distinguere dai livelli
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            level,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }*/
}