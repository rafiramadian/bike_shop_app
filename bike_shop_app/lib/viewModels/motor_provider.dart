import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum MotorState { loading, none, error }

class MotorProvider extends ChangeNotifier {
  Motor? _motor;
  Motor? get motor => _motor;

  MotorState _motorState = MotorState.none;
  MotorState get motorState => _motorState;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestore = FirestoreService();

  changeState(MotorState motorState) {
    _motorState = motorState;
    notifyListeners();
  }

  Future<void> getMotor() async {
    try {
      changeState(MotorState.loading);
      _motor = await firestore.getMotor();
      changeState(MotorState.none);
    } catch (e) {
      changeState(MotorState.error);
    }
  }

  Future<String?> addMotor(Motor motor) async {
    try {
      changeState(MotorState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.addMotor(user, motor);
        await getMotor();
        changeState(MotorState.none);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(MotorState.error);
      return e.toString();
    }
  }

  Future<String?> updateMotor(Motor motor) async {
    try {
      changeState(MotorState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.updateMotor(user, motor);
        await getMotor();
        changeState(MotorState.none);
        return 'Success';
      } else {
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(MotorState.error);
      return e.toString();
    }
  }
}
