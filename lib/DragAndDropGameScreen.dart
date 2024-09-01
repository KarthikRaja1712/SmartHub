import 'package:sih/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class DragAndDropGameScreen extends StatefulWidget {
  final String question;
  final List<String> choices;
  final List<String> correctAnswers;

  const DragAndDropGameScreen({
    super.key,
    required this.question,
    required this.choices,
    required this.correctAnswers,
  });

  @override
  _DragAndDropGameScreenState createState() => _DragAndDropGameScreenState();
}

class _DragAndDropGameScreenState extends State<DragAndDropGameScreen>
    with TickerProviderStateMixin {
  final List<String> draggedItems = [];
  late AudioPlayer player;
  late AnimationController shakeController;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              //    Navigator.push(
              //  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              itemCount: widget.choices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: widget.choices[index],
                  child: ChoiceWidget(choice: widget.choices[index]),
                  feedback: Material(
                    child: ChoiceWidget(choice: widget.choices[index]),
                  ),
                  childWhenDragging: const ChoiceWidget(choice: ''),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDragTarget(0),
                _buildDragTarget(1),
                _buildDragTarget(2), // Added third drag target
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(int index) {
    return DragTarget<String>(
      onAccept: (receivedItem) async {
        if (widget.correctAnswers.contains(receivedItem) &&
            !draggedItems.contains(receivedItem) &&
            draggedItems.length < widget.correctAnswers.length) {
          setState(() {
            draggedItems.add(receivedItem);
          });
          if (draggedItems.length == widget.correctAnswers.length) {
            await player.setSource(AssetSource('win.mp3'));
            await player.resume();
            _showWinDialog();
          }
        } else {
          shakeController.forward(from: 0.0);
          await player.setSource(AssetSource('wrong.mp3'));
          await player.resume();
        }
      },
      builder: (context, acceptedItems, rejectedItems) {
        return ShakeWidget(
          shakeController: shakeController,
          child: Container(
            width: 90,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Center(
              child: draggedItems.length > index
                  ? Text(
                      draggedItems[index],
                      style: const TextStyle(fontSize: 12),
                    )
                  : const Text('Drop here'),
            ),
          ),
        );
      },
    );
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text(
            "You have matched the correct answers!",
            style: TextStyle(fontSize: 18),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FlipCardGameScreen(
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
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      draggedItems.clear();
    });
  }
}

class ChoiceWidget extends StatelessWidget {
  final String choice;

  const ChoiceWidget({super.key, required this.choice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[
            choice.hashCode % Colors.primaries.length], // Assigning color
      ),
      child: Text(
        choice,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ShakeWidget extends StatelessWidget {
  final AnimationController shakeController;
  final Widget child;

  const ShakeWidget(
      {super.key, required this.shakeController, required this.child});

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
