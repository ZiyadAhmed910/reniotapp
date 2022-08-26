import 'package:bmi/screens/data_page.dart';
import 'package:bmi/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi/components/icon_content.dart';
import 'package:bmi/components/reusable_card.dart';
import 'package:bmi/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Gender { male, female, no }

class InputPage extends StatefulWidget {
  InputPage({this.currentSystemState1, this.currentSystemTemperature});

  final currentSystemState1;
  final currentSystemTemperature;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.no;
  int temperature = 25;
  String StatusIDSystem1 = "Error";
  String setStatusIDSystem1 = "off";
  String CurrentTemp = "Error";

  @override
  void initState() {
    super.initState();
    getMyData();
    updateUI(widget.currentSystemState1, widget.currentSystemTemperature);
  }

  void updateUI(dynamic currentSystemData, dynamic currentSystemTemperature) {
    String statusUpdateUI = currentSystemData["led"][0]["status"];
    String tempUpdateUI = currentSystemTemperature["led"][0]["currenttemp"];
    StatusIDSystem1 = statusUpdateUI;
    CurrentTemp = tempUpdateUI;
  }

  void getMyData() async {
    var url = Uri.parse('http://3.109.108.68/api/led/read_all.php?id=1');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      var statusID1 = decodedData["led"][0]["status"];
      print(statusID1);
      StatusIDSystem1 = statusID1;
    } else {
      print(response.statusCode);
    }
  }

  void getCurrentTemp() async {
    var url = Uri.parse('http://3.109.108.68/api/led/read_currentTemp.php');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      var currentTemp = decodedData["led"][0]["currenttemp"];
      print(currentTemp);
      CurrentTemp = currentTemp;
    } else {
      print(response.statusCode);
    }
  }

  void setTemperatureData() async {
    var url = Uri.parse(
        'http://3.109.108.68/api/led/setTemp.php?id=1&settemp=$temperature');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      var setTempMessage = decodedData["message"];
      print(setTempMessage);
    } else {
      print(response.statusCode);
    }
  }

  void updateMyData() async {
    var url = Uri.parse(
        'http://3.109.108.68/api/led/update.php?id=1&status=$setStatusIDSystem1');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
      var statusIDMessage = decodedData["message"];
      print(statusIDMessage);
    } else {
      print(response.statusCode);
    }
  }

  void getDetailedData() async {
    NetworkHelper networkHelper =
        NetworkHelper('http://3.109.108.68/api/led/read_all.php?id=1');
    var detailedData = await networkHelper.getData();
    print('Current Data is: $detailedData');
    NetworkHelper networkHelper2 =
        NetworkHelper('http://3.109.108.68/api/led/read_setTemp.php?id=1');
    var setTempdetailedData = await networkHelper2.getData();
    print('Current Set Temp Data is: $setTempdetailedData');
    NetworkHelper networkHelper3 =
        NetworkHelper('http://3.109.108.68/api/led/read_currentTemp.php');
    var currentTempdetailedData = await networkHelper3.getData();
    print('Current Temp Data is: $currentTempdetailedData');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DataPage(
                  systemState1detailedData: detailedData,
                  setTempDetailedData: setTempdetailedData,
                  currentTempdetailedData: currentTempdetailedData,
                )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RENIOT'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCardFlutter(
                      onPressHandler: () {
                        setState(() {
                          selectedGender = Gender.male;
                          setStatusIDSystem1 = "on";
                          StatusIDSystem1 = "on";
                          updateMyData();
                        });
                      },
                      colour: selectedGender == Gender.male
                          ? kactiveCardColour
                          : kinactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.lightbulb,
                        label: 'ON',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCardFlutter(
                      onPressHandler: () {
                        setState(() {
                          selectedGender = Gender.female;
                          setStatusIDSystem1 = "off";
                          StatusIDSystem1 = "off";
                          updateMyData();
                        });
                      },
                      colour: selectedGender == Gender.female
                          ? kactiveCardColour
                          : kinactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.xmark,
                        label: 'OFF',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCardFlutter(
                      onPressHandler: () {
                        print("Does Nothing");
                      },
                      colour: kactiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CURRENT STATUS',
                            style: klabelTextStyle,
                          ),
                          Text(
                            StatusIDSystem1.toUpperCase(),
                            style: kNumberTextStyle,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     RoundIconButton(
                          //       icon: FontAwesomeIcons.minus,
                          //       onPressed: () {
                          //         setState(() {
                          //           weight--;
                          //         });
                          //       },
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     RoundIconButton(
                          //       icon: FontAwesomeIcons.plus,
                          //       onPressed: () {
                          //         setState(() {
                          //           weight++;
                          //         });
                          //       },
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCardFlutter(
                      onPressHandler: () {
                        print("Does Nothing");
                      },
                      colour: kactiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "CURRENT TEMP",
                            style: klabelTextStyle,
                          ),
                          Text(
                            "$CurrentTemp°",
                            style: kNumberTextStyle,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     RoundIconButton(
                          //       icon: FontAwesomeIcons.minus,
                          //       onPressed: () {
                          //         setState(() {
                          //           age--;
                          //         });
                          //       },
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     RoundIconButton(
                          //       icon: FontAwesomeIcons.plus,
                          //       onPressed: () {
                          //         setState(() {
                          //           age++;
                          //         });
                          //       },
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCardFlutter(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SET TEMPERATURE",
                      style: klabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          temperature.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          '°',
                          style: kNumberTextStyle,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Color(0xFF8D8E98),
                              overlayColor: Color(0x29EB1555),
                              thumbColor: Color(0xFFEB1555),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0),
                            ),
                            child: Slider(
                              value: temperature.toDouble(),
                              min: -10.0,
                              max: 40.0,
                              activeColor: Color(0xFFEB1555),
                              inactiveColor: Color(0xFF8D8E98),
                              onChanged: (double newValue) {
                                setState(() {
                                  temperature = newValue.round();
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: RoundIconButton(
                              icon: FontAwesomeIcons.check,
                              onPressed: () {
                                setTemperatureData();
                              }),
                        )
                      ],
                    ),
                  ],
                ),
                onPressHandler: () {
                  print("Does Nothing");
                },
                colour: kactiveCardColour,
              ),
            ),
            GestureDetector(
              onTap: () {
                getDetailedData();
              },
              child: Container(
                child: Center(
                  child: Text(
                    'DETAILS',
                    style: kLargeButtonTextStyle,
                  ),
                ),
                color: kbottomContainerColour,
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: kbottomContainerHeight,
              ),
            ),
          ],
        ));
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      elevation: 6.0,
    );
  }
}
