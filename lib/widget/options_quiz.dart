import '../data/questions_data.dart';
import 'package:flutter/material.dart';
import '../themes/colors.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

//creazione risposte
Widget buildOption(BuildContext context, Option option) {
  final colorBorder = getColorForOption(option, question);

  return Column(
    children: [
      GestureDetector(
        onTap: () => onClickedOption(option),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: colorBorder, width: 2.5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                option.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: greyColorCP,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              getIconForOption(option, question)
            ],
          ),
        ),
      ),
    ],
  );
}
//colore risposte
Color getColorForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect ? Colors.green : Colors.red;
    } else if (option.isCorrect) {
      return Colors.green;
    }
  }
  return greyColorCP;
}

//gestire icone
Widget getIconForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.cancel, color: Colors.red);
    } else if (option.isCorrect) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
  }
  return const SizedBox.shrink();
}
}
