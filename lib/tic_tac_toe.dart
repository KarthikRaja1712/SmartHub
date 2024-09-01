import 'package:flutter/material.dart';
import 'game_logic.dart';
import 'question_logic.dart';
import 'dart:math';

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool isPlayerTurn = true;
  bool questionAnsweredCorrectly = false;
  final QuestionManager questionManager = QuestionManager(); // Initialize QuestionManager

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz-X-O'),
      ),
      body: SingleChildScrollView(  // Wrap content in a scrollable view
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQuestionBar(),
            _buildBoard(),
            _buildTurnIndicator(),
          ],
        ),
      ),
    );
  }
  Widget _buildQuestionBar() {
    final question = questionManager.getNextQuestion(); // Get the next question
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10.0, // Space between buttons horizontally
            runSpacing: 10.0, // Space between rows vertically
            children: question.options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  if (option == question.correctAnswer) {
                    setState(() {
                      questionAnsweredCorrectly = true;
                    });
                  } else {
                    setState(() {
                      isPlayerTurn = false;
                      questionAnsweredCorrectly = false;
                      _computerTurn(); // Computer plays immediately if the answer is wrong
                    });
                  }
                },
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (isPlayerTurn && board[index] == '' && questionAnsweredCorrectly) {
              setState(() {
                board[index] = currentPlayer;
                isPlayerTurn = false;
                questionAnsweredCorrectly = false;
                checkWinner();
                if (currentPlayer == 'X') {
                  currentPlayer = 'O';
                  _computerTurn();
                }
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: _getTileColor(index),
            ),
            child: Center(
              child: Text(
                board[index],
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTurnIndicator() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[300],
      child: Text(
        isPlayerTurn
            ? 'Turn X'
            : 'Turn O',
        style: TextStyle(
          color: isPlayerTurn ? Colors.green : Colors.orange,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getTileColor(int index) {
    if (board[index] == '') {
      return Color(0xFFF7DDAA); // Default tile color
    } else if (board[index] == 'X') {
      return Color(0xFFBFEF93); // Player X color
    } else {
      return Color(0xFF80CBDE); // Computer O color
    }
  }

  void _computerTurn() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        int index = _getRandomEmptyTile();
        if (index != -1) {
          board[index] = 'O';
          currentPlayer = 'X';
          isPlayerTurn = true;
          checkWinner();
        }
      });
    });
  }

  int _getRandomEmptyTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyTiles.add(i);
      }
    }
    if (emptyTiles.isNotEmpty) {
      final random = Random();
      return emptyTiles[random.nextInt(emptyTiles.length)];
    }
    return -1;
  }

  void checkWinner() {
    String winner = getWinner(board);
    if (winner.isNotEmpty) {
      _showWinnerDialog(winner);
    }
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Game Over"),
        content: Text("$winner wins!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                board = List.filled(9, '');
                currentPlayer = 'X';
                isPlayerTurn = true;
                questionAnsweredCorrectly = false;
              });
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }
}
