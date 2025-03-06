import 'package:flutter/material.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: 60, // Adjust size for border
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, // Change to desired border color
          width: 3, // Border thickness
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/tabtabicat.png', // Make sure the path is correct
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}