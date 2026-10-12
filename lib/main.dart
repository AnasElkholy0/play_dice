import 'dart:math';

import 'package:flutter/material.dart';

import 'dice.dart';

void main() {
  runApp(const MyApp());
}

/// Root of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Dice',
      debugShowCheckedModeBanner: false,
      // Dark theme with a purple accent color
      theme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.purpleAccent,
            ),
      ),
      home: const DiceScreen(),
    );
  }
}

/// Main game screen (stateful because the dice values change).
class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  // Initial state: both dice show 1, total is 2, sad image.
  int _dice1 = 1;
  int _dice2 = 1;
  int _total = 2;
  String _imagePath = 'assets/sad.png';

  /// Rolls both dice and updates the result.
  void _rollDice() {
    final random = Random();
    setState(() {
      // nextInt(6) gives 0..5, so add 1 to get 1..6
      _dice1 = random.nextInt(6) + 1;
      _dice2 = random.nextInt(6) + 1;
      _total = _dice1 + _dice2;
      // Win only when total is strictly greater than 10
      _imagePath = _total > 10 ? 'assets/happy.png' : 'assets/sad.png';
    });
  }

  /// Restores the initial state.
  void _resetGame() {
    setState(() {
      _dice1 = 1;
      _dice2 = 1;
      _total = 2;
      _imagePath = 'assets/sad.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isWin = _total > 10;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: const Icon(Icons.casino),
        title: const Text('Play Dice'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Total is $_total',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Result image and message take the free space in the middle
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Image.asset(_imagePath, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isWin ? 'You Win!' : 'You Lose',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // The two dice
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Dice(value: _dice1),
                  Dice(value: _dice2),
                ],
              ),
              const SizedBox(height: 24),
              // Roll and Reset buttons with equal width
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: _buttonStyle,
                      onPressed: _rollDice,
                      child: const Text('Roll'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: _buttonStyle,
                      onPressed: _resetGame,
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Red rounded buttons with readable white text
  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      );
}
