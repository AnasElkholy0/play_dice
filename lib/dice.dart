import 'package:flutter/material.dart';

/// A reusable widget that shows one die face (value 1 to 6).
class Dice extends StatelessWidget {
  /// The number shown on the die (1 to 6).
  final int value;

  const Dice({super.key, required this.value})
      : assert(value >= 1 && value <= 6, 'Dice value must be 1 to 6');

  /// Returns the icon that matches the die value.
  IconData _iconForValue(int value) {
    switch (value) {
      case 1:
        return Icons.looks_one;
      case 2:
        return Icons.looks_two;
      case 3:
        return Icons.looks_3;
      case 4:
        return Icons.looks_4;
      case 5:
        return Icons.looks_5;
      default:
        return Icons.looks_6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.purple.shade100, // light-purple background
        borderRadius: BorderRadius.circular(16), // rounded corners
      ),
      child: Icon(
        _iconForValue(value),
        size: 80,
        color: Colors.deepPurple.shade900, // dark icon
      ),
    );
  }
}
