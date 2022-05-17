import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({ Key? key }) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {

  var buttonColor = Colors.grey[400];

  double voltLoss = 0.0;
  double wattLoss = 0.0;
  List<double> LoadLoss = [];

  TextEditingController uLoad = TextEditingController();
  TextEditingController vLoad = TextEditingController();
  TextEditingController wLoad = TextEditingController();
  TextEditingController measuredWatt = TextEditingController();
  TextEditingController measuredVolt = TextEditingController();

  void _addToLoad () {
    double current;
    if(uLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(uLoad.text);
    }
    LoadLoss.add(current);

    if(vLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(vLoad.text);
    }
    LoadLoss.add(current);

    if(wLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(wLoad.text);
    }
    LoadLoss.add(current);
  }

  double _wattLoss () {
    if(measuredWatt.text == ''){
      wattLoss = 0.0;
    }
    else{
      wattLoss = double.parse(measuredWatt.text);
    }
    return wattLoss;
  }

  double _voltLoss () {
    if(measuredVolt.text == ''){
      voltLoss = 0.0;
    }
    else{
      voltLoss = double.parse(measuredVolt.text);
    }
    return voltLoss;
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
            const Text('Load Loss',
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Load Currents (A)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                      children: [
                        Container(
                            width: 350.0,
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                  controller: uLoad,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                    InputDecoration(
                                      labelText: 'U winding',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                ),
                          ),
                          Container(
                            width: 350.0,
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                  controller: vLoad,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                    InputDecoration(
                                      labelText: 'V winding',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                ),
                          ),
                          Container(
                            width: 350.0,
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                                  controller: wLoad,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                    InputDecoration(
                                      labelText: 'W winding',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 15.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                            child: const Text('Impedance Voltage (V) and Load Loss (W)',
                              style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 350.0,
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: measuredVolt,
                                keyboardType: TextInputType.number,
                                decoration:
                                  InputDecoration(
                                    labelText: 'Measured impedance voltage',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  ),
                                ),
                            ),
                            Container(
                              width: 350.0,
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: measuredWatt,
                                keyboardType: TextInputType.number,
                                decoration:
                                  InputDecoration(
                                    labelText: 'Measured load loss in Watt',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ]
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: RaisedButton(
                    onPressed: () {
                      _addToLoad();                  
                      transformer.addLoadLosses(_wattLoss(), _voltLoss(), LoadLoss);
                      setState(() {
                        buttonColor = Colors.greenAccent[400];
                      });
                    },
                    color: buttonColor,
                    child: const Icon(Icons.check),
                    ),
                  ),
                ],
              ),
            ],
          ),
          FlatButton.icon(
            onPressed: () {
              if(transformer.loadLosses.isNotEmpty){
                transformer.increaseProgress();
              }
              Navigator.pushReplacementNamed(context, '/home');
              },
            icon: const Icon(Icons.checklist_rounded),
            label: const Text('Done',
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 15.0,
              ),),
            color: Colors.greenAccent[400],
            ),
        ],
      ),
    );
  }
}
