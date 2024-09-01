import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  GradientBackground({required this.child});
  @override  
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFdee1fe), // Start color (light blue gradient)
            Colors.white, // End color (white)
          ],
          stops: [0.0, 0.8], // Adjust the gradient stops to match the look
        ),
      ),
      child: child,
    );
  }
}
