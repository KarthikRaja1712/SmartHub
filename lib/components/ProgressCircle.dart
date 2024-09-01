import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final int percentage;

  const ProgressCircle({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90, // Same width as height for a perfect circle
      height: 90,
      decoration: BoxDecoration(
        color: Colors.blue[50], // Light background color
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle with thin stroke
          CircularProgressIndicator(
            value: 1.0, // Complete circle
            strokeWidth: 0, // Slightly thicker stroke for outer circle
            backgroundColor: Colors
                .transparent, // Transparent background to only show the stroke
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.grey[300]!), // Background circle color
          ),
          // Foreground progress indicator with a larger stroke width
          Container(
            width: 70, // Decrease the size of the container to reduce the gap
            height: 70,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 8, // Larger stroke width for thicker progress bar
              backgroundColor: Colors
                  .transparent, // No background for the progress bar itself
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue), // Progress bar color
            ),
          ),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
