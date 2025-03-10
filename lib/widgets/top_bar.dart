import 'package:flutter/material.dart';
import 'package:ristekflix/helpers/user_things.dart';
import 'package:ristekflix/services/firestore_service.dart';
import 'package:ristekflix/widgets/accessories/home_profile.dart';
import 'package:ristekflix/widgets/buttons/notification_button.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
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
                    stream: firestoreService.getUsernameStream(),
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
