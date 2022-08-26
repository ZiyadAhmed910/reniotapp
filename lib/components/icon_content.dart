import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon = FontAwesomeIcons.mars, this.label = "Hello"});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: Color(0xFFFFFFFF),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          label,
          style: klabelTextStyle,
        )
      ],
    );
  }
}
