import 'package:bmi/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/input_page.dart';

void main() => runApp(BMICalculator());

//updated flutter code to build material colour for primary
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //METHOD 1
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: buildMaterialColor(Color(0xFF0A0E21)),
        ).copyWith(secondary: Color(0xFFD1D7DC)),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      //METHOD 2
      // theme: ThemeData.dark().copyWith(
      //   colorScheme: ColorScheme.fromSwatch(
      //       primarySwatch: buildMaterialColor(Color(0xFF0A0E21))),
      //   scaffoldBackgroundColor: Color(0xFF0A0E21),
      // ),
      home: LoadingScreen(),
    );
  }
}