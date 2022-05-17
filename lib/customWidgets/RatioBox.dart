import 'package:flutter/material.dart';


class RatioBoxWidget extends StatefulWidget {
  final String label;

  const RatioBoxWidget({Key? key, required this.label}) : super(key: key);

  @override
  _CheckRatio createState() => _CheckRatio();
}

class _CheckRatio extends State<RatioBoxWidget> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        Checkbox(
          onChanged: (newValue) => setState(() {
             _value = newValue;
          }),
          value: _value,
        ),
      ],
    );
  }
}