import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /* USER */

  /// Get user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById() {
    return _db.collection('users').doc(AuthService().auth.currentUser!.uid).snapshots();
  }

  /// Add user data
  Future<void> addUser(User user, UserApp userApp) {
    return _db.collection('users').doc(user.uid).set(UserApp.toMap(userApp));
  }

  /// Update user data
  Future<void> updateUser(User user, UserApp userApp) {
    return _db.collection('users').doc(user.uid).update(UserApp.toMap(userApp));
  }

  /* MOTOR */

  /// Get motor user data
  Future<Motor?> getMotor() async {
    final result = await _db
        .collection('users')
        .doc(AuthService().auth.currentUser!.uid)
        .collection('motor')
        .doc(AuthService().auth.currentUser!.uid)
        .get();
    if (result.data() != null) {
      final motor = Motor.fromFirestore(result.data()!);
      return motor;
    }
    return null;
  }

  /// Add motor user data
  Future<void> addMotor(User user, Motor motor) {
    return _db.collection('users').doc(user.uid).collection('motor').doc(user.uid).set(Motor.toMap(motor));
  }

  /// Update motor user data
  Future<void> updateMotor(User user, Motor motor) {
    return _db.collection('users').doc(user.uid).collection('motor').doc(user.uid).update(Motor.toMap(motor));
  }

  /* TRANSAKSI */

  /// Get transaksi servis data
  Future<Transaksi?> getTransaksiServis() async {
    final result = await _db
        .collection('transaksi')
        .doc(AuthService().auth.currentUser!.uid)
        .collection('servis')
        .doc(AuthService().auth.currentUser!.uid)
        .get();
    if (result.data() != null) {
      final transaksi = Transaksi.fromFirestore(result.data()!, AuthService().auth.currentUser!.uid);
      return transaksi;
    }
    return null;
  }

  /// Get list transaksi sparepart data
  Future<List<Transaksi>> getTransaksiSparepart() async {
    final result =
        await _db.collection('transaksi').doc(AuthService().auth.currentUser!.uid).collection('sparepart').get();
    if (result.docs.isNotEmpty) {
      final List<Transaksi> transaksi =
          result.docs.map((item) => Transaksi.fromFirestore(item.data(), item.id)).toList();
      return transaksi;
    }
    return [];
  }

  /// Add transaksi servis data
  Future<void> addTransaksiServis(User user, Transaksi transaksi) {
    return _db.collection('transaksi').doc(user.uid).collection('servis').doc(user.uid).set(Transaksi.toMap(transaksi));
  }

  /// Add transaksi sparepart data
  Future<void> addTransaksiSparepart(User user, Transaksi transaksi) {
    return _db.collection('transaksi').doc(user.uid).collection('sparepart').doc().set(Transaksi.toMap(transaksi));
  }

  /// Delete transaksi servis data
  Future<void> deleteTransaksiServis(User user) async {
    var collection = await FirebaseFirestore.instance.collection('transaksi').doc(user.uid).collection('servis').get();
    for (var doc in collection.docs) {
      await doc.reference.delete();
    }
  }

  /// Delete transaksi sparepart by id
  Future<void> deleteTransaksiSparepart(User user, String id) {
    return _db.collection('transaksi').doc(user.uid).collection('sparepart').doc(id).delete();
  }

  /* RIWAYAT */

  /// Get riwayat data
  Future<List<Transaksi>> getRiwayat() async {
    final result = await _db
        .collection('transaksi')
        .doc(AuthService().auth.currentUser!.uid)
        .collection("riwayat")
        .orderBy("tanggalDatang", descending: true)
        .get();
    if (result.docs.isNotEmpty) {
      final List<Transaksi> transaksi =
          result.docs.map((item) => Transaksi.fromFirestore(item.data(), item.id)).toList();
      return transaksi;
    }
    return [];
  }

  /// Add riwayat data
  Future<void> addRiwayat(User user, Transaksi transaksi) {
    return _db.collection('transaksi').doc(user.uid).collection('riwayat').doc().set(Transaksi.toMap(transaksi));
  }
}
