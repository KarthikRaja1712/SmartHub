import 'package:flutter/material.dart';

class WordBlanks extends StatelessWidget {
  final String answer;
  final Set<String> selectedLetters;

  const WordBlanks({
    required this.answer,
    required this.selectedLetters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: answer.split('').map((char) {
          if (char == ' ' || !RegExp(r'[A-Z]').hasMatch(char)) {
            return Text(
              char,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              selectedLetters.contains(char) ? char : '_',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }
}
