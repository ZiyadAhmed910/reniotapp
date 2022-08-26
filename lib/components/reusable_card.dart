import 'package:flutter/material.dart';

class ReusableCardFlutter extends StatelessWidget {
  ReusableCardFlutter({
    required this.colour,
    this.cardChild = const SizedBox(
      height: 120,
      width: double.infinity,
    ),
    required this.onPressHandler,
  });

  final Color colour;
  final Widget cardChild;
  final VoidCallback onPressHandler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressHandler,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
