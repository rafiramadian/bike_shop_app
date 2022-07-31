import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAppProvider {
  final FirestoreService firestore = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Get user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> get userApp => firestore.getUserById();

  /// Update user data
  Future<String?> updateProfile(UserApp userApp) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.updateUser(user, userApp);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}
