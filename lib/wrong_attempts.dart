import 'package:flutter/material.dart';

class WrongAttemptsDisplay extends StatelessWidget {
  final int wrongGuesses;

  const WrongAttemptsDisplay({required this.wrongGuesses});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Icon(
          Icons.close,
          color: index < wrongGuesses ? Colors.red : const Color.fromARGB(235, 199, 178, 1),
          size: 36.0,
        );
      }),
    );
  }
}
