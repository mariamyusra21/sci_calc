import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPress;
  final textColor;
  const Button({
    Key? key,
    required this.text,
    required this.onPress,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          onPressed: () {
            onPress();
          },
          style: ElevatedButton.styleFrom(
              maximumSize: Size.fromHeight(70),
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              padding: EdgeInsets.all(16)),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 19, fontWeight: FontWeight.bold),
          )),
    ));
  }
}
