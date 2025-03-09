import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ristekflix/authentication/auth.dart';
import 'package:ristekflix/screens/home_screen.dart';
import 'package:ristekflix/widgets/buttons/custom_button.dart';
import 'package:ristekflix/widgets/credential_field.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPw = TextEditingController();
  final TextEditingController tecConfirmPw = TextEditingController();

  bool isLogin = true;

  Future<void> signInWithEmailPassword(BuildContext context) async {
    try {
      await Auth()
          .signInWithEmailPassword(email: tecEmail.text, password: tecPw.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message!);
    }
  }

  Future<void> createUserWithEmailPassword(BuildContext context) async {
    if (tecPw.text != tecConfirmPw.text) {
      _showErrorDialog(context, "Passwords do not match!");
      return;
    }

    try {
      await Auth().createUserWithEmailPassword(
          email: tecEmail.text, password: tecPw.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message!);
    }
  }

  Widget _loginOrRegisterButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin ? "Register instead" : "Login instead",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CredentialField("Email", tecEmail),
              const SizedBox(height: 20),
              CredentialField("Password", tecPw),
              if (!isLogin) ...[
                const SizedBox(height: 20),
                CredentialField("Confirm Password", tecConfirmPw),
              ],
              const SizedBox(height: 100),
              MainButton(
                () {
                  if (tecEmail.text.isEmpty || tecPw.text.isEmpty) {
                    _showErrorDialog(context, "Both fields must be filled!");
                  } else if (!isLogin && tecConfirmPw.text.isEmpty) {
                    _showErrorDialog(context, "Please confirm your password!");
                  } else {
                    isLogin
                        ? signInWithEmailPassword(context)
                        : createUserWithEmailPassword(context);
                  }
                },
                isLogin ? "Login" : "Register",
              ),
              SizedBox(height: 20),
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF5038BC),
    );
  }
}
