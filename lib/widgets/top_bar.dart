import 'package:flutter/material.dart';
import 'package:ristekflix/helpers/user_things.dart';
import 'package:ristekflix/widgets/accessories/home_profile.dart';
import 'package:ristekflix/widgets/buttons/notification_button.dart';
import 'package:ristekflix/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  Stream<String> _usernameStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(getUsernameFromEmail());

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      return data?["username"] ?? getUsernameFromEmail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HomeProfile(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: _usernameStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        );
                      }
                      return Text(
                        snapshot.data ?? getUsernameFromEmail(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                ],
              ),
              NotificationButton(),
            ],
          ),
        ),
      ],
    );
  }
}
