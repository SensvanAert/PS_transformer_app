import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class InducedVoltagePage extends StatefulWidget {
  const InducedVoltagePage({ Key? key }) : super(key: key);

  @override
  State<InducedVoltagePage> createState() => _InducedVoltagePageState();
}

class _InducedVoltagePageState extends State<InducedVoltagePage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer () {
    setState(() => seconds = maxSeconds);

  }

  void startTimer ({bool reset = true}) {

    if (reset){
      resetTimer();
    }

    timer = Timer.periodic(const Duration(milliseconds: 1), (_){
      if (seconds > 0){
        setState(() => seconds --);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer ({bool reset = true}) {
    if (reset){
      resetTimer();
    }
    setState(() => timer?.cancel ());
  }

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
                  const Text('Induced Voltage',
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Induced Overvoltage Withstand Test (840V - 100Hz)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              buildTimer(),
              const SizedBox(height: 80),
              Container(
                child: buildButtons(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
    ? Row(
      children: [
        timeButtonWidget(
            text: isRunning ? 'Pause' : 'Resume',
            onClicked: () {
              if (isRunning) {
                stopTimer(reset: false);
              } else {
                startTimer(reset: false);
              }
            }
            ),
        const SizedBox(width: 15,),
        timeButtonWidget(
            text: 'Cancel',
            onClicked: () => stopTimer(reset: true)
            ),
      ],
    )

    : timerDone();

  }

  Widget timerDone () {
    final isCompleted = seconds == 0;

    if(!isCompleted) {
      return timeButtonWidget(
        text: 'Start timer',
        onClicked: () {startTimer();},
      );
    } else {
      return timeButtonWidget(text: 'Done', onClicked: () {
        transformer.increaseProgress();
        transformer.setInducedVoltage();
        Navigator.pushReplacementNamed(context, '/home');
      }
      );
    }
  }

  Widget buildTimer () => SizedBox(
    width: 200,
    height: 200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: 1- seconds / maxSeconds,
          strokeWidth: 10,
          backgroundColor: Colors.blue[100],
        ),
        Center(child: timerDisp()),
      ],
    ),
  );

  Widget timerDisp () {

    if (seconds == 0){
      return Icon(Icons.done, size: 70, color: Colors.greenAccent[400],);
    } else {
      return Text(
        '$seconds',
        style: const TextStyle(
          fontSize: 70.0,
        ),
      );
    }

    
  }
}



// ignore: camel_case_types
class timeButtonWidget extends StatelessWidget {
  
  final String text;
  final VoidCallback onClicked;

  const timeButtonWidget({ Key? key, required this.text, required this.onClicked, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      child: Text(text,
        style: const TextStyle(
          fontSize: 20.0,
          ),
      ),
      onPressed: onClicked,
    );
  }
}
