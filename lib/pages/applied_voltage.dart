import 'dart:async';
import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class AppliedVoltagePage extends StatefulWidget {
  const AppliedVoltagePage({ Key? key }) : super(key: key);

  @override
  State<AppliedVoltagePage> createState() => _AppliedVoltagePageState();
}

class _AppliedVoltagePageState extends State<AppliedVoltagePage> {
  static const maxSeconds1 = 60;
  int seconds1 = maxSeconds1;
  Timer? timer1;

  static const maxSeconds2 = 60;
  int seconds2 = maxSeconds1;
  Timer? timer2;

  var buttonColor = Colors.blue[400];
  var doneColor = Colors.blue[400];
  var doneColor2 = Colors.blue[400];

  // Timer 1
  void resetTimer1 () {
    setState(() => seconds1 = maxSeconds1);
  }

  void startTimer1 ({bool reset = true}) {
    if (reset){
      resetTimer1();
    }

    timer1 = Timer.periodic(const Duration(milliseconds: 1), (_){
      if (seconds1 > 0){
        setState(() => seconds1 --);
      } else {
        stopTimer1(reset: false);
      }
    });
  }

  void stopTimer1 ({bool reset = true}) {
    if (reset){
      resetTimer1();
    }
    setState(() => timer1?.cancel ());
  }

  // Timer 2
  void resetTimer2 () {
    setState(() => seconds2 = maxSeconds2);
  }

  void startTimer2 ({bool reset2 = true}) {
    if (reset2){
      resetTimer2();
    }

    timer2 = Timer.periodic(const Duration(milliseconds: 1), (_){
      if (seconds2 > 0){
        setState(() => seconds2 --);
      } else {
        stopTimer2(reset2: false);
      }
    });
  }

  void stopTimer2 ({bool reset2 = true}) {
    if (reset2){
      resetTimer2();
    }
    setState(() => timer2?.cancel ());
  }

  // Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('images/IEO_Logo.png'),
                  const Text('Applied Voltage',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
        backgroundColor: Colors.grey[400],
        elevation: 5.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 5.0),
            child: const Text('Rated Withstand Voltage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'High Voltage (28kV - 50Hz)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  buildTimer2(),
                  const SizedBox(height: 80),
                  Container(
                    child: buildButtons2(),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Low Voltage (3kV - 50Hz)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  buildTimer1(),
                  const SizedBox(height: 80),
                  Container(
                    child: buildButtons1(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Timer 1
  Widget buildButtons1() {
    final isRunning = timer1 == null ? false : timer1!.isActive;
    final isCompleted = seconds1 == maxSeconds1 || seconds1 == 0;

    return isRunning || !isCompleted
    ? Row(
      children: [
        timeButtonWidget1(
            text: isRunning ? 'Pause' : 'Resume',
            onClicked: () {
              if (isRunning) {
                stopTimer1(reset: false);
              } else {
                startTimer1(reset: false);
              }
            },
            buttonColor: doneColor
            ),
        const SizedBox(width: 15,),
        timeButtonWidget1(
            text: 'Cancel',
            onClicked: () => stopTimer1(reset: true),
            buttonColor: doneColor
        ),
      ],
    )
    : timerDone1();
  }

  Widget timerDone1 () {
    final isCompleted = seconds1 == 0;

    if(!isCompleted) {
      return timeButtonWidget1(
        text: 'Start timer',
        onClicked: () => startTimer1(),
        buttonColor: doneColor
      );
    } else {
      return timeButtonWidget1(text: 'Done', onClicked: () {
        transformer.setAppliedLowVoltage();
        setState(() => doneColor = Colors.greenAccent[400]);
        if(transformer.appliedHighVoltage && transformer.appliedLowVoltage){
          transformer.increaseProgress();
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      buttonColor: doneColor
      );
    }
  }

  Widget buildTimer1 () => SizedBox(
    width: 200,
    height: 200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: 1- seconds1 / maxSeconds1,
          strokeWidth: 10,
          backgroundColor: Colors.blue[100],
        ),
        Center(child: timerDisp1()),
      ],
    ),
  );

  Widget timerDisp1 () {
    if (seconds1 == 0){
      return Icon(Icons.done, size: 70, color: Colors.greenAccent[400],);
    } else {
      return Text(
        '$seconds1',
        style: const TextStyle(
          fontSize: 70.0,
        ),
      );
    }
  }

  // Timer 2
  Widget buildButtons2() {
    final isRunning2 = timer2 == null ? false : timer2!.isActive;
    final isCompleted2 = seconds2 == maxSeconds2 || seconds2 == 0;

    return isRunning2 || !isCompleted2
    ? Row(
      children: [
        timeButtonWidget2(
            text: isRunning2 ? 'Pause' : 'Resume',
            onClicked: () {
              if (isRunning2) {
                stopTimer2(reset2: false);
              } else {
                startTimer2(reset2: false);
              }
            },
            buttonColor: doneColor2
            ),
        const SizedBox(width: 15,),
        timeButtonWidget2(
            text: 'Cancel',
            onClicked: () => stopTimer2(reset2: true),
            buttonColor: doneColor2
            ),
      ],
    )
    : timerDone2();
  }

  Widget timerDone2 () {
    final isCompleted2 = seconds2 == 0;

    if(!isCompleted2) {
      return timeButtonWidget2(
        text: 'Start timer',
        onClicked: () {startTimer2();},
        buttonColor: doneColor2,
      );
    } else {
      return timeButtonWidget2(text: 'Done', onClicked: () {
        transformer.setAppliedHighVoltage();
        setState(() => doneColor2 = Colors.greenAccent[400]);
        if(transformer.appliedHighVoltage && transformer.appliedLowVoltage){
          transformer.increaseProgress();
          Navigator.pushReplacementNamed(context, '/home');
          }
        },
        buttonColor: doneColor2
      );
    }
  }

  Widget buildTimer2 () => SizedBox(
    width: 200,
    height: 200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: 1- seconds2 / maxSeconds2,
          strokeWidth: 10,
          backgroundColor: Colors.blue[100],
        ),
        Center(child: timerDisp2()),
      ],
    ),
  );

  Widget timerDisp2 () {

    if (seconds2 == 0){
      return Icon(Icons.done, size: 70, color: Colors.greenAccent[400],);
    } else {
      return Text(
        '$seconds2',
        style: const TextStyle(
          fontSize: 70.0,
        ),
      );
    }
  }
}

// Timer 1
// ignore: camel_case_types
class timeButtonWidget1 extends StatelessWidget {
  
  final String text;
  final VoidCallback onClicked;
  var buttonColor;

  timeButtonWidget1({ Key? key, required this.text, required this.onClicked, required this.buttonColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      child: Text(text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          ),
      ),
      onPressed: onClicked,
      color: buttonColor,
    );
  }
}

// Timer 2
// ignore: camel_case_types
class timeButtonWidget2 extends StatelessWidget {
  
  final String text;
  final VoidCallback onClicked;
  var buttonColor;

  timeButtonWidget2({ Key? key, required this.text, required this.onClicked, required this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      child: Text(text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white
          ),
      ),
      onPressed: onClicked,
      color: buttonColor,
    );
  }
}
