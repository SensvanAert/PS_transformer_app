import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';

class noLoadPage extends StatefulWidget {
  const noLoadPage({ Key? key }) : super(key: key);

  @override
  State<noLoadPage> createState() => _noLoadPageState();
}

class _noLoadPageState extends State<noLoadPage> {

  var buttonColor = Colors.grey[400];

  double voltLoss = 0.0;
  List<double> noLoadLoss = [];

  TextEditingController uNoLoad = TextEditingController();
  TextEditingController vNoLoad = TextEditingController();
  TextEditingController wNoLoad = TextEditingController();
  TextEditingController measuredLoss = TextEditingController();

  void _addToNoLoad () {
    double current;
    if(uNoLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(uNoLoad.text);
    }
    noLoadLoss.add(current);

    if(vNoLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(vNoLoad.text);
    }
    noLoadLoss.add(current);

    if(wNoLoad.text == ''){
      current = 0.0;
    }
    else{
      current = double.parse(wNoLoad.text);
    }
    noLoadLoss.add(current);
  }

  double _voltLoss () {
    if(measuredLoss.text == ''){
      voltLoss = 0.0;
    }
    else{
      voltLoss = double.parse(measuredLoss.text);
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
            const Text('No Load Loss',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('No Load Currents (A)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Row(
                  children: [
                    Container(
                        width: 350.0,
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                              controller: uNoLoad,
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
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                              controller: vNoLoad,
                              keyboardType: TextInputType.number,
                              decoration:
                                InputDecoration(
                                  hintText: 'No load current on V winding',
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
                              controller: wNoLoad,
                              keyboardType: TextInputType.number,
                              decoration:
                                InputDecoration(
                                  hintText: 'No load current on W winding',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('No Load Loss (W)',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                    Container(
                      width: 350.0,
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: TextField(
                        controller: measuredLoss,
                        keyboardType: TextInputType.number,
                        decoration:
                          InputDecoration(
                            hintText: 'Measured No load loss in Watt',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              ),
                          ),
                        ),
                    ),
                  ],
                ),
                ]
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: RaisedButton(
                onPressed: () {
                  _addToNoLoad();                  
                  transformer.addNoLoadLosses(_voltLoss(), noLoadLoss);
                  setState(() {
                    buttonColor = Colors.greenAccent[400];
                  });
                },
                color: buttonColor,
                child: Icon(Icons.check),
                ),
              ),
            ],
          ),
          FlatButton.icon(
            onPressed: () {
              if(transformer.noLoadLosses.isNotEmpty){
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
