import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped});

  final Color textColor;
  final Color color;
  final String buttonText;
  final VoidCallback buttonTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 250.0,
              minWidth: 20.0,
            ),
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
