import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ristekflix/helpers/user_things.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserData(
      String username, List<String> genres) async {
    final user = _auth.currentUser;
    if (user != null) {
     await _db.collection("users").doc(user.uid).set({
        "username": username,
        "preferredGenres": genres,
      }, SetOptions(merge: true));
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await _db.collection("users").doc(user.uid).get();
        return doc.exists ? doc.data() as Map<String, dynamic> : null;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Stream<String> getUsernameStream() {
    final user = _auth.currentUser;
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

  Stream<Map<String, dynamic>?> getUserDataStream() {
    final user = _auth.currentUser;
    if (user != null) {
      return _db.collection("users").doc(user.uid).snapshots().map(
        (snapshot) => snapshot.exists ? snapshot.data() as Map<String, dynamic> : null,
      );
    }
    return Stream.value(null);
  }
}
