import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({ Key? key }) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  ratioPart () {
    if(transformer.ratioOk) {
      return  const Text("All ratios are OK",
        style:TextStyle(
          fontSize: 18.0,
        ),
      );
    }
    else {
      return const Icon(
        Icons.not_interested,
        color: Colors.red,);
    }

  }

  rtdWithstandTests () {
    String rtdWhistand = '';
    if(transformer.appliedHighVoltage && transformer.appliedLowVoltage){
      rtdWhistand = "Rated Whistand Voltages are OK (28kV - 50Hz - 60s / 3kV - 50Hz - 60s)";
    }
    return rtdWhistand;
  }

  inducedTest () {
    String induced = '';
    if(transformer.inducedVoltage) {
      induced = "Induced Overvoltage Wisthand is OK (840V - 100Hz - 60s)";
    }
    return induced;
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
                  const Text('Summary',
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
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 10.0, 10.0),
                child: Text('Transformer: '  + transformer.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 30.0, 30.0, 10.0),
                child: Text('Rating: '  + transformer.power.toString() + 'kVA, ' + transformer.primaryVoltage.toString() + '/'
                             + transformer.secundaryVoltage.toString() + 'V, +/- 2x250V',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 30.0, 30.0, 10.0),
                child: Text('Temperature: '  + transformer.temperature.toString() + '°C',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),),
              ),
            ],
          ),
          const Divider(height: 30.0, color: Colors.black),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        "Ratios: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(60.0, 10, 10, 10),
                      child: ratioPart(),
                  ),
                  ],
                ),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          "Dielectric Tests: ",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(60.0, 10, 10, 10),
                            child: Text(
                              rtdWithstandTests(),
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(60.0, 10, 10, 10),
                            child: Text(
                              inducedTest(),
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 30.0, color: Colors.black),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        "No load losses: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  "Voltage (V): ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
                                child: Text(
                                  transformer.secundaryVoltage.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  "Currents (A): ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'U: ' + transformer.noLoadLosses.elementAt(1).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'V: ' + transformer.noLoadLosses.elementAt(2).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'W: ' + transformer.noLoadLosses.elementAt(3).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'AVG: ' + transformer.calcAvgNoLoadCurrent().toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  "Losses (W): ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
                                child: Text(
                                  transformer.noLoadLosses.first.toString(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),  
                  ],
                ),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                        "Resistances: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  "LV Resistance (mΩ): ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [ 
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "UV: " + transformer.resistanceLV.elementAt(0).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "UW: " + transformer.resistanceLV.elementAt(1).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "VW: " + transformer.resistanceLV.elementAt(2).toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ] 
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text(
                                    "HV Resistance(Ω): ",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "UV: " + transformer.resistanceHV.elementAt(0).toString(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "UW: " + transformer.resistanceHV.elementAt(1).toString(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "VW: " + transformer.resistanceHV.elementAt(2).toString(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         const Divider(height: 30.0, color: Colors.black),
         Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      "Load losses: ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "Impedance Voltage (V): ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    transformer.loadLosses.elementAt(1).toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    '%' + transformer.percentImpedanceVAt75Degrees().toString() + ' at 75°C',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "Currents (A): ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'U: ' + transformer.loadLosses.elementAt(2).toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'V: ' + transformer.loadLosses.elementAt(3).toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'W: ' + transformer.loadLosses.elementAt(4).toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'AVG: ' + transformer.calcAvgLoadCurrent().toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "Losses at 75°C (W): ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
                              child: Text(
                                transformer.loadLossAt75Degrees().toString(),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),  
                ],
              ), 
        ],
      )
    );
  }
}