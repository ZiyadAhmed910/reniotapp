import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bmi/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bmi/screens/input_page.dart';
import 'package:bmi/constants.dart';

const apiKey = '78163efabb094f2c66f8931f0e5ee998';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentSystemData();
  }

  void getCurrentSystemData() async {
    NetworkHelper networkHelper =
        NetworkHelper('http://3.109.108.68/api/led/read_all.php?id=1');
    var currentSystemState1 = await networkHelper.getData();
    print('Current Data is: $currentSystemState1');

    NetworkHelper networkHelper2 =
        NetworkHelper('http://3.109.108.68/api/led/read_currentTemp.php');
    var currentSystemTemperature = await networkHelper2.getData();
    print('Current Data is: $currentSystemTemperature');
    var duration = new Duration(seconds: 5);
    new Timer(duration, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return InputPage(
          currentSystemState1: currentSystemState1,
          currentSystemTemperature: currentSystemTemperature,
        );
      }));
    });
  }

  Widget build(BuildContext context) {
//    getMyData();
    return GestureDetector(
      onTap: () {
        getCurrentSystemData();
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SpinKitFoldingCube(
                color: Colors.yellow,
                size: 100.0,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text("INFINOS TECH", style: kBodyzhTextStyle),
            SizedBox(
              height: 250,
            ),
            Text("RENIOT", style: kBodyzTextStyle),
            SizedBox(
              height: 25,
            ),
            Text("Developed by Ziyad Ahmed", style: kBodyzTextStyle),
          ],
        ),
      ),
    );
  }
}
