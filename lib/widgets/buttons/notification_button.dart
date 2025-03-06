import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, 
        shape: BoxShape.circle, 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.notifications_none_outlined,
            color: Color(0xFF5038BC)), 
        iconSize: 25, 
        onPressed: () {
          print("Notification button clicked!");
        },
      ),
    );
  }
}