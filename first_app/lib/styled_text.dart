import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.outputText, {super.key}); // 1. text props

  final String outputText; // 2. assigning to variable

  @override
  Widget build(context) {
    return Text(
      outputText, // 3. then use it
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
