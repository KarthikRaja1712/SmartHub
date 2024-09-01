import 'package:flutter/material.dart';
import 'package:sih/DragAndDropGameScreen.dart';
//import 'package:confetti/confetti.dart';  // Import the confetti package
import 'question_container.dart';
import 'letter_selection.dart';
import 'word_blanks.dart';
import 'wrong_attempts.dart';

class WordWorldGame extends StatefulWidget {
  @override
  _WordWorldGameState createState() => _WordWorldGameState();
}

class _WordWorldGameState extends State<WordWorldGame> {
  final String question = 'What is the supreme law of the land in India?';
  final String answer = 'CONSTITUTION'; // Update as needed
  Set<String> selectedLetters = {};
  Map<String, Color> letterColors = {};
  int wrongGuesses = 0;
  // late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    //  _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    letterColors = Map.fromIterable(
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''),
      key: (e) => e as String,
      value: (e) => Colors.white,
    );
  }

  void _onLetterSelected(String letter) {
    setState(() {
      if (answer.contains(letter)) {
        // Make sure to mark the letter as green
        letterColors[letter] = Colors.green;
        selectedLetters.add(letter);

        // Check for a win condition after adding the correct letter
        if (_checkWinCondition()) {
          _showCongratsDialog();
        }
      } else {
        // Incorrect guess logic
        letterColors[letter] = Colors.red;
        wrongGuesses += 1;

        // Check for game over condition
        if (wrongGuesses >= 3) {
          _showGameOverDialog();
        }
      }
    });
  }

  bool _checkWinCondition() {
    return answer.split('').every((char) {
      // Check if the character is in selectedLetters or it's a space/punctuation
      return char == ' ' || char == ',' || selectedLetters.contains(char);
    });
  }

  void _showCongratsDialog() {
//  _confettiController.play();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congrats!!'),
        content: Text('You have completed the word!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DragAndDropGameScreen(
                    question:
                        'What are the three groups that divide the work in the Indian Constitution?',
                    choices: [
                      'Legislature',
                      'Executive',
                      'Judiciary',
                      'Bureaucracy',
                      'Military',
                      'Media',
                    ],
                    correctAnswers: ['Legislature', 'Executive', 'Judiciary'],
                  ),
                ),
              );
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('You have used all your attempts.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      selectedLetters.clear();
      letterColors = Map.fromIterable(
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''),
        key: (e) => e as String,
        value: (e) => Colors.white,
      );
      wrongGuesses = 0;
    });
  }

  @override
  void dispose() {
    // _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word World'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            QuestionContainer(question: question),
                            SizedBox(height: 10),
                            WordBlanks(
                                answer: answer,
                                selectedLetters: selectedLetters),
                            // SizedBox(height: 10),
                            LetterSelection(
                              letterColors: letterColors,
                              onLetterSelected: _onLetterSelected,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //      SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: WrongAttemptsDisplay(wrongGuesses: wrongGuesses),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Container(
          //         child: ConfettiWidget(
          //         confettiController: _confettiController,
          //         numberOfParticles: 20,
          //         maxBlastForce: 40,
          //         minBlastForce: 10,
          //         blastDirectionality: BlastDirectionality.explosive, // Blast in all directions
          //         shouldLoop: false,
          //         colors: [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          //         //blastDirection: 180,  // Adjust this to create a diagonal blast from the sides
          //       ),
          // )
        ],
      ),
    );
  }
}
