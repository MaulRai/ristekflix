import 'package:flutter/material.dart';
import 'package:ristekflix/authentication/auth.dart';
import 'package:ristekflix/screens/login_register_screen.dart';
import 'package:ristekflix/screens/main_screen.dart';

class AuthStream extends StatefulWidget {
  const AuthStream({super.key});

  @override
  State<AuthStream> createState() => _AuthStreamState();
}

class _AuthStreamState extends State<AuthStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainScreen();
        } else {
          return const LoginRegisterScreen();
        }
      },
    );
  }
}