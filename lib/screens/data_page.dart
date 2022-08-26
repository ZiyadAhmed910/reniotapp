import 'package:bmi/constants.dart';
import 'package:bmi/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataPage extends StatefulWidget {
  DataPage(
      {this.systemState1detailedData,
      this.setTempDetailedData,
      this.currentTempdetailedData});

  final systemState1detailedData;
  final setTempDetailedData;
  final currentTempdetailedData;

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String StatusIDSystem1 = "Error";
  String Desciption = "Error";
  String setTempData = "Error";
  String currentTempData = "Error";
  String setTempTimeData = "Error";
  String currentTempTimeData = "Error";

  @override
  void initState() {
    super.initState();
    getMyData();
    updateUI(widget.systemState1detailedData, widget.setTempDetailedData,
        widget.currentTempdetailedData);
  }

  void updateUI(dynamic systemStateDetailedData, dynamic setTempDetailedData,
      dynamic currentTempDetailedData) {
    String systemStatusUpdateUI = systemStateDetailedData["led"][0]["status"];
    StatusIDSystem1 = systemStatusUpdateUI;
    if (systemStatusUpdateUI == "off") {
      Desciption = "The System is currently turned OFF.";
    } else {
      Desciption = "The System is currently turned ON.";
    }
    String setTempDataUpdateUI = setTempDetailedData["led"][0]["settemp"];
    setTempData = setTempDataUpdateUI;
    String setTempTimeDataUpdateUI = setTempDetailedData["led"][0]["timestamp"];
    setTempTimeData = setTempTimeDataUpdateUI;
    String currentTempDataUpdateUI =
        currentTempDetailedData["led"][0]["currenttemp"];
    currentTempData = currentTempDataUpdateUI;
    String currentTempTimeDataUpdateUI =
        currentTempDetailedData["led"][0]["timestamp"];
    currentTempTimeData = currentTempTimeDataUpdateUI;
  }

  void getMyData() async {
    var url = Uri.parse('https://3.109.108.68/api/led/read_all.php?id=1');
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RENIOT"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Server Data Report',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: ReusableCardFlutter(
              onPressHandler: () {},
              colour: kactiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StatusIDSystem1.toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    "setTemp:$setTempData°",
                    style: kResultTextStyle,
                  ),
                  Text(
                    "currentTemp:$currentTempData°",
                    style: kResultTextStyle,
                  ),
                  // Text(
                  //   StatusIDSystem1.toUpperCase(),
                  //   style: kBMITextStyle,
                  // ),
                  // Text(
                  //   "$Desciption The set temperature is $setTempData° and the last updated time was $setTempTimeData. The current temperature is $setTempData ° and the last updated time was $currentTempTimeData.",
                  //   style: kBodyTextStyle,
                  //   textAlign: TextAlign.center,
                  // ),
                  Text(
                    Desciption,
                    style: kBodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "The set temperature is $setTempData° and the last updated time was $setTempTimeData. ",
                    style: kBodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "The current temperature is $setTempData° and the last updated time was $currentTempTimeData. ",
                    style: kBodyTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              setState(() {
                getMyData();
              });
            },
            child: Container(
              child: Center(
                child: Text(
                  'UPDATE PAGE',
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
      ),
    );
  }
}
