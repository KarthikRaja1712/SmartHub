import 'package:flutter/material.dart';

class QuestionContainer extends StatelessWidget {
  final String question;

  const QuestionContainer({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey,
      child: Text(
        question,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
