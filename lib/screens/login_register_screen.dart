import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ristekflix/authentication/auth.dart';
import 'package:ristekflix/authentication/auth_stream.dart';
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
        MaterialPageRoute(builder: (context) => AuthStream()),
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
        MaterialPageRoute(builder: (context) => AuthStream()),
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
      backgroundColor: const Color(0xFF5038BC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        child: Image.asset("assets/images/ristekflix.png"),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: double.infinity,
                        child: Text(
                          isLogin ? "Login" : "Register",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CredentialField("Email", tecEmail),
                      const SizedBox(height: 20),
                      CredentialField("Password", tecPw),
                      if (!isLogin) ...[
                        const SizedBox(height: 20),
                        CredentialField("Confirm Password", tecConfirmPw),
                      ],
                      const SizedBox(height: 50),
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
                      const SizedBox(height: 20),
                      _loginOrRegisterButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
