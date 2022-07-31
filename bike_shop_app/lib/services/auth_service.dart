import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => auth.idTokenChanges();

  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String?> signUp(UserApp userApp) async {
    try {
      await auth.createUserWithEmailAndPassword(email: userApp.email, password: userApp.password).then((value) async {
        User? user = auth.currentUser;
        if (user != null) {
          await FirestoreService().addUser(user, userApp);
        }
      });

      return 'Success';
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<void> updateEmail(String email, String password, String newEmail) async {
    await auth.signInWithEmailAndPassword(email: email, password: password).then((userCredential) {
      userCredential.user!.updateEmail(newEmail);
    });
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
