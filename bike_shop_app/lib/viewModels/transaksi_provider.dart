import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum TransaksiState { loading, none, error }

class TransaksiProvider extends ChangeNotifier {
  Transaksi? _transaksi;
  Transaksi? get transaksi => _transaksi;

  List<Transaksi> _listTransaksiSparepart = [];
  List<Transaksi> get listTransaksiSparepart => List.unmodifiable(_listTransaksiSparepart);

  List<Transaksi> _listRiwayat = [];
  List<Transaksi> get listRiwayat => List.unmodifiable(_listRiwayat);

  TransaksiState _transaksiState = TransaksiState.none;
  TransaksiState get transaksiState => _transaksiState;

  final FirestoreService firestore = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  changeState(TransaksiState transaksiState) {
    _transaksiState = transaksiState;
    notifyListeners();
  }

  // Stream<DocumentSnapshot<Map<String, dynamic>>> getTransaksiStream() => getTransaksiStream();

  Future<void> getListTransaksi() async {
    try {
      changeState(TransaksiState.loading);
      _transaksi = await firestore.getTransaksiServis();
      final listSparepart = await firestore.getTransaksiSparepart();
      _listTransaksiSparepart = listSparepart;
      changeState(TransaksiState.none);
    } catch (e) {
      changeState(TransaksiState.error);
    }
  }

  Future<String?> addTransaksiSparepart(Transaksi transaksi) async {
    try {
      changeState(TransaksiState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.addTransaksiSparepart(user, transaksi);
        changeState(TransaksiState.none);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(TransaksiState.error);
      return e.toString();
    }
  }

  Future<String?> deleteTransaksiSparepart(String id) async {
    try {
      changeState(TransaksiState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.deleteTransaksiSparepart(user, id);
        changeState(TransaksiState.none);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(TransaksiState.error);
      return e.toString();
    }
  }

  Future<void> getTransaksiServis() async {
    try {
      _transaksi = await firestore.getTransaksiServis();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> addTransaksiServis(Transaksi transaksi) async {
    try {
      changeState(TransaksiState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.addTransaksiServis(user, transaksi);
        changeState(TransaksiState.none);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(TransaksiState.error);
      return e.toString();
    }
  }

  Future<String?> deleteTransaksiServis() async {
    try {
      changeState(TransaksiState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.deleteTransaksiServis(user);
        changeState(TransaksiState.none);
        notifyListeners();
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(TransaksiState.error);
      return e.toString();
    }
  }

  Future<void> getRiwayat() async {
    try {
      changeState(TransaksiState.loading);
      final listRiwayat = await firestore.getRiwayat();
      _listRiwayat = listRiwayat;
      changeState(TransaksiState.none);
    } catch (e) {
      changeState(TransaksiState.error);
    }
  }

  Future<void> addRiwayat(Transaksi transaksi) async {
    try {
      changeState(TransaksiState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.addRiwayat(user, transaksi);
        changeState(TransaksiState.none);
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(TransaksiState.error);
    }
  }
}
