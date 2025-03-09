import 'package:firebase_auth/firebase_auth.dart';

const String apiKey =
    'a8fe2c893a6c51ef87d21f2c7bc02a26'; // Replace with your TMDb API Key

String getUsernameFromEmail() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.email != null) {
    return user.email!.split('@')[0]; 
  }
  return "Unknown";
}