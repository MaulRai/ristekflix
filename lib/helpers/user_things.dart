import 'package:firebase_auth/firebase_auth.dart';

String getUsernameFromEmail() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.email != null) {
    return user.email!.split('@')[0]; 
  }
  return "Unknown";
}