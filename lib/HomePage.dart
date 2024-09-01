import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih/DragAndDropGameScreen.dart';
import 'package:sih/components/GradientBackground.dart';
import 'package:sih/flip.dart';
import 'package:sih/main.dart';
import 'package:sih/word_world_game.dart';
import 'package:flutter/material.dart';
import 'tic_tac_toe.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 83, 108, 247),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Games",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ))),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.collections,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing:
                          16.0, // Spacing between items horizontally
                      mainAxisSpacing: 16.0, // Spacing between items vertically
                    ),
                    itemCount: _imageButtons.length,
                    itemBuilder: (context, index) {
                      final item = _imageButtons[index];
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          elevation: 10,
                          color: Colors.white,
                          child: ImageButton(
                            imagePath: item['imagePath']!,
                            label: item['label']!,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item['screen'],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 20,
              child: Container(
                child: Image.asset("assets/bot.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const ImageButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> _imageButtons = [
  {
    'imagePath': 'assets/flip_card_image.jpeg',
    'label': 'Flip Card Game',
    'screen': const FlipCardGameScreen(
      question:
          'In which country did the Constitution start working on January 26, 1950?',
      images: [
        'assets/INDIA.jpg',
        'assets/UK.png',
        'assets/CANADA.png',
        'assets/ireland.jpg',
        'assets/INDIA.jpg',
        'assets/CANADA.png',
        'assets/PAKISTAN.png',
        'assets/ireland.jpg',
        'assets/UK.png',
      ],
      correctImage: 'assets/INDIA.jpg',
    ),
  },
  {
    'imagePath': 'assets/quiz_x_o.jpg',
    'label': 'Quiz X O',
    'screen': TicTacToeScreen(),
  },
  {
    'imagePath': 'assets/word_world.jpg',
    'label': 'Word World',
    'screen': WordWorldGame(),
  },
  {
    'imagePath': 'assets/game_2.jpg',
    'label': 'Drag and Drop Game',
    'screen': const DragAndDropGameScreen(
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
  },
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageButton(
            imagePath: 'assets/flip_card_image.jpeg', // Path to the first image
            label: 'Flip Card Game',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlipCardGameScreen(
                    question:
                        'How many fundamental rights are guaranteed by the Constitution? Match the correct answer.',
                    images: [
                      'assets/image8.png',
                      'assets/image5.png',
                      'assets/image7.png',
                      'assets/image6.png',
                      'assets/image7.png',
                      'assets/image5.png',
                      'assets/image8.png',
                      'assets/image6.png',
                      'assets/image7.png',
                    ],
                    correctImage: 'assets/image6.png',
                  ),
                ),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/quiz_x_o.jpg', // Path to the first image
            label: 'Quiz X O',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicTacToeScreen(),
                ),
              );
            },
          ),
          ImageButton(
            imagePath: 'assets/word_world.jpg', // Path to the first image
            label: 'Word World',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WordWorldGame(),
                ),
              );
            },
          ),
          //const SizedBox(height: 20),
          ImageButton(
            imagePath: 'assets/game_2.jpg', // Path to the second image
            label: 'Drag and Drop Game',
            onTap: () {
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
          ),
        ],
      ),
    ),
  );
}

class FlipCardGameScreen extends StatefulWidget {
  final String question;
  final List<String> images;
  final String correctImage;

  const FlipCardGameScreen({
    super.key,
    required this.question,
    required this.images,
    required this.correctImage,
  });

  @override
  _FlipCardGameScreenState createState() => _FlipCardGameScreenState();
}

class _FlipCardGameScreenState extends State<FlipCardGameScreen>
    with TickerProviderStateMixin {
  late List<bool> cardFlipped;
  late List<int> selectedCards;
  bool allowSelection = false;
  int timerCountdown = 5;
  late AudioPlayer player;
  late AnimationController shakeController;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    cardFlipped = List<bool>.filled(widget.images.length, true);
    selectedCards = [];
    startTimer();

    shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    player.dispose();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timerCountdown > 0) {
          timerCountdown--;
        } else {
          allowSelection = true;
          cardFlipped = List<bool>.filled(widget.images.length, false);
          timer.cancel();
        }
      });
    });
  }

  void flipCard(int index) async {
    if (!allowSelection || cardFlipped[index] || selectedCards.length == 2) {
      return;
    }

    setState(() {
      cardFlipped[index] = true;
      selectedCards.add(index);
    });

    await player.setSource(AssetSource('click.mp3')); // Card flip sound
    await player.resume();
    if (selectedCards.length == 2) {
      if (widget.images[selectedCards[0]] == widget.images[selectedCards[1]] &&
          widget.images[selectedCards[0]] == widget.correctImage) {
        await Future.delayed(const Duration(seconds: 1));
        _showWinDialog();
      } else {
        await Future.delayed(const Duration(seconds: 1));
        shakeController.forward(from: 0.0); // Shake effect on wrong attempt
        await player.setSource(AssetSource('wrong.mp3')); // Wrong pair sound
        await player.resume();
        setState(() {
          cardFlipped[selectedCards[0]] = false;
          cardFlipped[selectedCards[1]] = false;
          selectedCards.clear();
        });
      }
    }
  }

  void _showWinDialog() async {
    await player.setSource(AssetSource('win.mp3')); // Win sound effect
    await player.resume();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You have matched the correct answer.",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Explanation: Indian Constitution is  the longest written constitution in the world and was adopted on November 26, 1949, and started working on January 26, 1950",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
            ),
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => TicTacToeScreen()));
              },
            )
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      cardFlipped = List<bool>.filled(widget.images.length, true);
      allowSelection = false;
      timerCountdown = 5;
      selectedCards.clear();
      startTimer();
    });
  }

  void _skipGame() {
    setState(() {
      _restartGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Card Memory Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _restartGame,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.question,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            if (timerCountdown > 0)
              Text(
                'Get ready! Cards will flip in $timerCountdown seconds.',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => flipCard(index),
                    child: ShakeWidget(
                      shakeController: shakeController,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        elevation: 12,
                        color: Colors.white,
                        child: cardFlipped[index]
                            ? Image.asset(widget.images[index])
                            : Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShakeWidget extends StatelessWidget {
  final AnimationController shakeController;
  final Widget child;

  const ShakeWidget({
    super.key,
    required this.shakeController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeController,
      builder: (context, childWidget) {
        double offsetX = shakeController.value * 10.0;
        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: childWidget,
        );
      },
      child: child,
    );
  }
}
