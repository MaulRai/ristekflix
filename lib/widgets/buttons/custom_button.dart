import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final String colorCode;
  const MainButton(this.onPressed, this.text,
      {this.colorCode = "w", super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor:
            colorCode == "w" ? Colors.white : const Color(0xFF5038BC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colorCode == "w" ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
