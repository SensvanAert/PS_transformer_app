import 'package:flutter/material.dart';


class ProgressWidget extends StatefulWidget {

  final double testValue;


  const ProgressWidget({ Key? key, required this.testValue }) : super(key: key);

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Test Progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0
          ),
        ),
        LinearProgressIndicator(value: widget.testValue,
        minHeight: 10,),
      ],
    );
  }
}