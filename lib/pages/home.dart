import 'package:flutter/material.dart';
import 'package:transformer_testing_app/customWidgets/button.dart';
import 'package:transformer_testing_app/customWidgets/progressBar.dart';
import 'package:transformer_testing_app/customClasses/Transformer.dart';

Transformer transformer = Transformer();

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController tempController = TextEditingController();
      var tempColor = Colors.blue[400];

  void _setTemperature () {
      double temp = 0.0;
    if(tempController.text == ''){
      temp = 0.0;
    }
    else{
      temp = double.parse(tempController.text);
      setState(() => tempColor = Colors.greenAccent[400]);
    }
    transformer.setTemperature(temp);
  }

  colorTemp () {
    if(transformer.temperature != 0.0){
      setState(() => tempColor = Colors.greenAccent[400]);
    }
    return tempColor;
  }

    colorOfButton() {
    var buttonColor = Colors.blue[400];
    if(transformer.isSummaryReady() == true){
      buttonColor = Colors.greenAccent[400];
    }
    return buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      title: Image.asset('images/IEO_Logo.png'),
      backgroundColor: Colors.grey[400],
      elevation: 5.0,
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 150.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Testing Procedures',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
            child: Container(
              width: 1000.0,
              child: ProgressWidget(testValue: transformer.testProgress)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    child: buttonWidget(test: 'Ratios', pageRoute: '/ratios', statement: transformer.ratioOk, ),
                    width: 200,
                  ),
                  const SizedBox(height: 10.0,),
                  Container(
                    child: buttonWidget(test: 'Resistances', pageRoute: '/resistance', statement: transformer.resistanceHV.isNotEmpty 
                                                                                                    && transformer.resistanceLV.isNotEmpty,),
                    width: 200,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: buttonWidget(test: 'Applied Voltage', pageRoute: '/applied', statement: transformer.appliedLowVoltage && transformer.appliedHighVoltage,),
                    width: 200,
                  ),
                  const SizedBox(height: 10.0,),
                  Container(
                    child: buttonWidget(test: 'Induced Voltage', pageRoute: '/induced', statement: transformer.inducedVoltage,),
                    width: 200,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: buttonWidget(test: 'No-Load Losses', pageRoute: '/noLoad', statement: transformer.noLoadLosses.isNotEmpty,),
                    width: 200,
                  ),
                  const SizedBox(height: 10.0,),
                  Container(
                    child: buttonWidget(test: 'Load Losses', pageRoute: '/load', statement: transformer.loadLosses.isNotEmpty,),
                    width: 200,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250.0,
                child: TextField(
                  controller: tempController,
                  keyboardType: TextInputType.number,
                  decoration:
                    InputDecoration(
                      hintText: 'In Degrees Celsius',
                      labelText: 'Enter oil temperature',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                ),
              ),
              const SizedBox(width: 20.0),
              Container(
                width: 50.0,
                child: RaisedButton(
                    onPressed: () => _setTemperature(),
                    color: colorTemp(),
                    child: const Icon(Icons.check),
                    ),
                  ),
            ],
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                if(transformer.isSummaryReady()) {
                  Navigator.pushReplacementNamed(context, '/summary');
                }  
              },
              color: colorOfButton(),
              child: const  Text('Summary',
              style: TextStyle(
                fontSize: 17.0,
                ),
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  tempColor = Colors.blue;
                  transformer.setTemperature(0.0);
                  transformer.loadLosses = [];
                  transformer.noLoadLosses = [];
                  transformer.addResistance([], []);
                  transformer.testProgress = 0;
                  transformer.appliedHighVoltage = false;
                  transformer.appliedLowVoltage = false;
                  transformer.inducedVoltage = false;
                  transformer.ratioOk = false; 
                  transformer.summaryReady = 0;
                });
              },
              color: Colors.blue,
              child: const  Text('New Transformer',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ), 
    );
  }
}
