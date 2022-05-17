import 'package:flutter/material.dart';


class buttonWidget extends StatefulWidget {

  final String test;
  final String pageRoute;
  final statement;
  // final arguments = '';

  buttonWidget({ Key? key, required this.test, required this.pageRoute, required this.statement,}) : super(key: key);

  @override
  State<buttonWidget> createState() => _buttonWidgetState();
}

// ignore: camel_case_types
class _buttonWidgetState extends State<buttonWidget> {



  colorOfButton() {
    var buttonColor = Colors.blue[400];
    if(widget.statement == true){
      buttonColor = Colors.greenAccent[400];
    }
    return buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, widget.pageRoute, );  
              },
              color: colorOfButton(),
              child: Text(widget.test,
              style: const TextStyle(
                fontSize: 17.0,
                ),
              ),
            );
  }
}