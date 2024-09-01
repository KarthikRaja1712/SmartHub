import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sih/HomePage.dart';

class FlipCardGame extends StatelessWidget {
  const FlipCardGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
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
                "Explanation: There are 6 fundamental rights guaranteed by the Constitution.",
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
      body: Column(
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
