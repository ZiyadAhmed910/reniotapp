import 'package:flutter/material.dart';
import 'package:bmi/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required buttonTitle, required onTap});

  final String buttonTitle = "CALCULATE";
  final VoidCallback onTap = () {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: kbottomContainerColour,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: kbottomContainerHeight,
      ),
    );
  }
}
