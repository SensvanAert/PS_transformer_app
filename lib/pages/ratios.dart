import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';
import 'package:transformer_testing_app/customClasses/Ratio.dart';
import 'package:transformer_testing_app/customWidgets/RatioBox.dart';



class RatioPage extends StatefulWidget {

  @override
  State<RatioPage> createState() => _RatioPageState();
}

class _RatioPageState extends State<RatioPage> {

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
            const Text('Ratios',
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ControleVak(),
          SizedBox(height: 20.0,),
          FlatButton.icon(
            onPressed: () {
              transformer.setRatioOK();
              transformer.increaseProgress();
              Navigator.pushReplacementNamed(context, '/home');
            },
            icon: const Icon(Icons.done_all),
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


class ControleVak extends StatelessWidget {
  
  List<Ratio> ratios = [
    Ratio('46.37', '46.37', '46.37'), Ratio('45.37', '45.37', '45.37'),
    Ratio('44.33', '44.33', '44.33'), Ratio('43.29', '43.29', '43.29'),
    Ratio('42.25', '42.25', '42.25'),];
  
  List<String> positions = [
    'Position 1: ', 'Position 2: ', 'Position 3: ', 'Position 4: ', 'Position 5: '];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'U',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 30.0,),
            Column(
              children: 
                ratios.map((ratio) => 
                    RatioBoxWidget(label: ratio.ratioU),).toList(),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'V',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 30.0,),
            Column(
              children: 
                ratios.map((ratio) => RatioBoxWidget(label: ratio.ratioV)).toList(),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'W',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 30.0,),
            Column(
              children: 
                ratios.map((ratio) => RatioBoxWidget(label: ratio.ratioW)).toList(),
            ),
          ],
        ),
      ],
    );
  }
}