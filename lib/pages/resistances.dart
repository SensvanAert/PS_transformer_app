import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class ResistancesPage extends StatefulWidget {
  const ResistancesPage({ Key? key }) : super(key: key);

  @override
  State<ResistancesPage> createState() => _ResistancesPageState();
}

class _ResistancesPageState extends State<ResistancesPage> {

  var LVcolor = Colors.grey[400];
  var HVcolor = Colors.grey[400];

  List<double> resistanceLV = [];
  List<double> resistanceHV = [];

  double resistance = 0.0;

  TextEditingController utoVLV = TextEditingController();
  TextEditingController utoWLV = TextEditingController();
  TextEditingController vtoWLV = TextEditingController();

  TextEditingController utoVHV = TextEditingController();
  TextEditingController utoWHV = TextEditingController();
  TextEditingController vtoWHV = TextEditingController();


  // LV resistance list
  void _addLVtoList () {
    if(utoVLV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(utoVLV.text);
    }
    resistanceLV.add(resistance);

    if(utoWLV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(utoWLV.text);
    }
    resistanceLV.add(resistance);

    if(vtoWLV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(vtoWLV.text);
    }
    resistanceLV.add(resistance);
  }

  //HV resistance list
  void _addHVtoList () {
    if(utoVHV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(utoVHV.text);
    }
    resistanceHV.add(resistance);

    if(utoWHV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(utoWHV.text);
    }
    resistanceHV.add(resistance);

    if(vtoWHV.text == ''){
      resistance = 0.0;
    }
    else{
      resistance = double.parse(vtoWHV.text);
    }
    resistanceHV.add(resistance);
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
            const Text('Resistances',
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  'High Voltage (Ω)',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                children: [
                  Container(
                    width: 350.0,
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                          controller: utoVHV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'U to V',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ),
                  ),
                  Container(
                    width: 350.0,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                          controller: utoWHV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'U to W',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ),
                  ),
                  Container(
                    width: 350.0,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                          controller: vtoWHV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'V to W',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ),
                  ),
                  Container(
                    width: 50.0,
                    child: RaisedButton(
                        onPressed: () {
                          _addHVtoList();
                          transformer.addResistance(resistanceLV, resistanceHV);
                          setState(() {
                            HVcolor = Colors.greenAccent[400];
                          });
                        },
                        color: HVcolor,
                        child: const Icon(Icons.check),
                      ),
                  ),
                ],
              ),
            ],
          ),
          ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  'Low Voltage (mΩ)',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350.0,
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                          controller: utoVLV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'U to V',
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
                          controller: utoWLV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'U to W',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ),
                  ),
                  Container(
                    width: 350.0,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                          controller: vtoWLV,
                          keyboardType: TextInputType.number,
                          decoration:
                            InputDecoration(
                              labelText: 'V to W',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                        ),
                  ),
                  Container(
                    width: 50.0,
                    child: RaisedButton(
                        onPressed: () {
                          _addLVtoList();
                          transformer.addResistance(resistanceLV, resistanceHV);
                          setState(() {
                            LVcolor = Colors.greenAccent[400];
                          });
                        },
                        color: LVcolor,
                        child: Icon(Icons.check),
                      ),
                    ),
                  ],
              ),
            ],
          ),
          
          FlatButton.icon(
            onPressed: () {
              if(transformer.resistanceHV.isNotEmpty && transformer.resistanceLV.isNotEmpty){
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
