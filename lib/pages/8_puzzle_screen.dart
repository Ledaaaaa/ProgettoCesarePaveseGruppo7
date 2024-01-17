import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:collection/collection.dart';

import '../themes/colors.dart';

class PuzzlePage extends StatefulWidget {
  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  List<int> puzzlePieces = List.generate(9, (index) => index);
  final int columns = 3;
  final int rows = 3;
  bool isCompleted = false;
  final String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRidqsaTapQJog-wUGkhp9myPlXA1as7e7Nug&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRidqsaTapQJog-wUGkhp9myPlXA1as7e7Nug&usqp=CAU';
  late Future<List<Image>> _images;
  late List<Image> _shuffledImages;
  int? selectedPiece;

  // Aggiunto lo stato del pulsante di mischiatura
  bool isShuffling = false;

  @override
  void initState() {
    super.initState();
    _images = _loadImagesFromAssets('assets/images/cesarepaveseritratto.jpeg');
    _shuffledImages = [];
  }

  Future<List<Image>> _loadImagesFromAssets(String assetPath) async {
    List<Image> images = [];

    try {
      ByteData data = await rootBundle.load(assetPath);
      List<int> bytes = data.buffer.asUint8List();
      img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

      final double pieceWidth = image.width / 3;
      final double pieceHeight = image.height / 3;

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final int x = (col * pieceWidth).toInt();
          final int y = (row * pieceHeight).toInt();
          final img.Image piece = img.copyCrop(image, x, y, pieceWidth.toInt(), pieceHeight.toInt())!;

          List<int> piecePngBytes = img.encodePng(piece);
          final ByteData pieceByteData = ByteData.sublistView(Uint8List.fromList(piecePngBytes));

          final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.sublistView(pieceByteData.buffer.asUint8List()));
          final ui.FrameInfo frameInfo = await codec.getNextFrame();
          final ui.Image frame = frameInfo.image;

          images.add(Image.memory(
            Uint8List.sublistView((await frame.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List()),
            width: 80, // Imposta la larghezza del quadrato
            height: 80, // Imposta l'altezza del quadrato
          ));
        }
      }

      // Memorizza una copia delle immagini iniziali
      _shuffledImages = List.from(images);
    } catch (e) {
      print('Error loading images from assets: $e');
    }

    return images;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPuzzleGrid(),
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
                  if (!isCompleted) {
                    setState(() {
                      isShuffling = true; // Imposta lo stato di mischiatura a true
                      // Mischiare sia i numeri che le immagini
                      puzzlePieces.shuffle();
                    });

                    // Dopo un breve periodo, reimposta lo stato di mischiatura a false
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      setState(() {
                        isShuffling = false;
                      });
                    });
                  }
                },
                child: const Text('Mischia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
              if (isCompleted)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Puzzle Completato!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPuzzleGrid() {
    return FutureBuilder<List<Image>>(
      future: _images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
            ),
            itemBuilder: (context, index) {
              return Draggable<int>(
                data: puzzlePieces[index],
                feedback: Material(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    color: Colors.blue.withOpacity(0.7),
                    child: Text(
                      puzzlePieces[index].toString(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                child: DragTarget<int>(
                  builder: (context, candidateData, rejectedData) {
                    return GestureDetector(
                      onTap: () {
                        if (!isCompleted && !isShuffling) {
                          setState(() {
                            // Seleziona l'immagine
                            selectedPiece = puzzlePieces[index];
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: selectedPiece == puzzlePieces[index] ? Colors.red : Colors.transparent, width: 2.0),
                          image: DecorationImage(
                            image: _shuffledImages[puzzlePieces[index]].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          puzzlePieces[index].toString(),
                          style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    return !isCompleted && !isShuffling;
                  },
                  onAccept: (data) {
                    setState(() {
                      puzzlePieces.remove(data);
                      puzzlePieces.insert(index, data);
                    });
                    checkCompletion();
                  },
                ),
              );
            },
            itemCount: puzzlePieces.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void checkCompletion() {
    if (const ListEquality().equals(puzzlePieces, List.generate(9, (index) => index))) {
      setState(() {
        isCompleted = true;
      });
      showCompletionDialog();
    }
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulazioni!'),
          content: const Text('Hai completato il puzzle.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}



/*import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:collection/collection.dart';

import '../themes/colors.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  _PuzzlePageState createState() {
    return _PuzzlePageState();
  }
}



class _PuzzlePageState extends State<PuzzlePage> {
  List<int> puzzlePieces = List.generate(9, (index) => index);
  final int columns = 3;
  final int rows = 3;
  bool isCompleted = false;
  final String imageUrl = 'assets/images/image_quiz.jpg';
  late Future<List<Image>> _images;
  late List<Image> _shuffledImages;
  int? selectedPiece;

// Aggiunto lo stato del pulsante di mischiatura
  bool isShuffling = false;

  @override
  void initState() {
    super.initState();
    _images = _loadImages(imageUrl);
    _shuffledImages = [];
  }

  Future<List<Image>> _loadImages(String imageUrl) async {
    List<Image> images = [];

    try {
      final ByteData byteData = await rootBundle.load(imageUrl);
      final Uint8List bytes = byteData.buffer.asUint8List();

      final img.Image image = img.decodeImage(bytes)!;

      List<int> pngBytes = img.encodePng(image);

      final double pieceWidth = image.width.toDouble() / 2;
      final double pieceHeight = image.height.toDouble() / 2;

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final int x = (col * pieceWidth).toInt();
          final int y = (row * pieceHeight).toInt();
          final img.Image piece = img.copyCrop(
            image,
            x,
            y,
            pieceWidth.toInt(),
            pieceHeight.toInt(),
          )!;

          List<int> piecePngBytes = img.encodePng(piece);
          final ByteData pieceByteData = ByteData.sublistView(Uint8List.fromList(piecePngBytes));

          final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.sublistView(pieceByteData.buffer.asUint8List()));
          final ui.FrameInfo frameInfo = await codec.getNextFrame();
          final ui.Image frame = frameInfo.image;

          images.add(
            Image.memory(
              Uint8List.sublistView((await frame.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List()),
              width: 80, // Imposta la larghezza del quadrato
              height: 80, // Imposta l'altezza del quadrato
            ),
          );
        }
      }
      // Memorizza una copia delle immagini iniziali
      _shuffledImages = List.from(images);
    } catch (e) {
      print('Error loading images: $e');
    }
    return images;
  }

  /*
  final String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRidqsaTapQJog-wUGkhp9myPlXA1as7e7Nug&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRidqsaTapQJog-wUGkhp9myPlXA1as7e7Nug&usqp=CAU';
  late Future<List<Image>> _images;
  late List<Image> _shuffledImages;
  int? selectedPiece;

  // Aggiunto lo stato del pulsante di mischiatura
  bool isShuffling = false;

  @override
  void initState() {
    super.initState();
    _images = _loadImages(imageUrl);
    _shuffledImages = [];
  }

  Future<List<Image>> _loadImages(String imageUrl) async {
    List<Image> images = [];

    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      final Uint8List bytes = response.bodyBytes;

      final img.Image image = img.decodeImage(bytes)!;

      List<int> pngBytes = img.encodePng(image);
      final ByteData byteData = ByteData.sublistView(Uint8List.fromList(pngBytes));

      final double pieceWidth = image.width / 3;
      final double pieceHeight = image.height / 3;

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final int x = (col * pieceWidth).toInt();
          final int y = (row * pieceHeight).toInt();
          final img.Image piece = img.copyCrop(image, x, y, pieceWidth.toInt(), pieceHeight.toInt())!;

          List<int> piecePngBytes = img.encodePng(piece);
          final ByteData pieceByteData = ByteData.sublistView(Uint8List.fromList(piecePngBytes));

          final ui.Codec codec = await ui.instantiateImageCodec(Uint8List.sublistView(pieceByteData.buffer.asUint8List()));
          final ui.FrameInfo frameInfo = await codec.getNextFrame();
          final ui.Image frame = frameInfo.image;

          images.add(Image.memory(
            Uint8List.sublistView((await frame.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List()),
            width: 80, // Imposta la larghezza del quadrato
            height: 80, // Imposta l'altezza del quadrato
          ));
        }
      }
      // Memorizza una copia delle immagini iniziali
      _shuffledImages = List.from(images);
    } catch (e) {
      print('Error loading images: $e');
    }
    return images;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPuzzleGrid(),
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
                  if (!isCompleted) {
                    setState(() {
                      isShuffling = true; // Imposta lo stato di mischiatura a true
                      // Mischiare sia i numeri che le immagini
                      puzzlePieces.shuffle();
                    });

                    // Dopo un breve periodo, reimposta lo stato di mischiatura a false
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      setState(() {
                        isShuffling = false;
                      });
                    });
                  }
                },
                child: const Text('Mischia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
              if (isCompleted)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Puzzle Completato!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPuzzleGrid() {
    return FutureBuilder<List<Image>>(
      future: _images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
            ),
            itemBuilder: (context, index) {
              return Draggable<int>(
                data: puzzlePieces[index],
                feedback: Material(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    color: Colors.blue.withOpacity(0.7),
                    child: Text(
                      puzzlePieces[index].toString(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                child: DragTarget<int>(
                  builder: (context, candidateData, rejectedData) {
                    return GestureDetector(
                      onTap: () {
                        if (!isCompleted && !isShuffling) {
                          setState(() {
                            // Seleziona l'immagine
                            selectedPiece = puzzlePieces[index];
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: selectedPiece == puzzlePieces[index] ? Colors.red : Colors.transparent, width: 2.0),
                          image: DecorationImage(
                            image: _shuffledImages[puzzlePieces[index]].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          puzzlePieces[index].toString(),
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    return !isCompleted && !isShuffling;
                  },
                  onAccept: (data) {
                    setState(() {
                      puzzlePieces.remove(data);
                      puzzlePieces.insert(index, data);
                    });
                    checkCompletion();
                  },
                ),
              );
            },
            itemCount: puzzlePieces.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  void checkCompletion() {
    if (const ListEquality().equals(puzzlePieces, List.generate(9, (index) => index))) {
      setState(() {
        isCompleted = true;
      });
      showCompletionDialog();
    }
  }
  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulazioni!'),
          content: const Text('Hai completato il puzzle.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        )
      },
    );
  }
}*/