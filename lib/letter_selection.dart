import 'package:flutter/material.dart';

class LetterSelection extends StatelessWidget {
  final Map<String, Color> letterColors;
  final Function(String) onLetterSelected;

  const LetterSelection({
    required this.letterColors,
    required this.onLetterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      
      spacing: 2.0,
      runSpacing: 2.0,
      children: letterColors.entries.map((entry) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                entry.value, // Corrected from `primary` to `backgroundColor`
          ),
          onPressed: entry.value == Colors.green
              ? null
              : () => onLetterSelected(entry.key),
          child: Text(entry.key),
        );
      }).toList(),
    );
  }
}
