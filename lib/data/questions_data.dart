class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final questions = [
  Question(
    text: 'Sono di legno o di metallo, mi accendo ma non sono una fiamma. Tra le dita mi stringo, fumo esalo con calma.',
    options: [
      const Option(text: 'Camino', isCorrect: false),
      const Option(text: 'Penna', isCorrect: false),
      const Option(text: 'Pipa', isCorrect: true),
      const Option(text: 'Occhiali', isCorrect: false)
    ],
  ),
  Question(
    text: 'Non lo fanno mai per caso, ti si siedono sul naso, cosa sono?',
    options: [
      const Option(text: 'Occhiali', isCorrect: true),
      const Option(text: 'Mosche', isCorrect: false),
      const Option(text: 'Lentiggini', isCorrect: false),
      const Option(text: 'Capelli', isCorrect: false)
    ],
  ),
  Question(
    text:
        'Sono ricchi di vignette e hanno storie diverse, scritti su carta e non su lavagnette, che cosa sono?',
    options: [
      const Option(text: 'Lettere', isCorrect: false),
      const Option(text: 'Fumetti', isCorrect: true),
      const Option(text: 'Quotidiano', isCorrect: false),
      const Option(text: 'Francobolli', isCorrect: false)
    ],
  ),
  Question(
    text:
        'Sulla carta viene scritta per restare, chiedendo perdono e dandolo senza spettegolare, cos’è? ',
    options: [
      const Option(text: 'Firma', isCorrect: true),
      const Option(text: "Lettera d'addio", isCorrect: false),
      const Option(text: 'Borraccia', isCorrect: false),
      const Option(text: 'Immagine', isCorrect: false)
    ],
  ),
];
