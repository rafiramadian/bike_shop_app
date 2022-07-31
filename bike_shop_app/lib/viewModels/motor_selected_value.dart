import 'package:flutter/cupertino.dart';

class MotorSelectedValue extends ChangeNotifier {
  String _motor = "Bandung";
  String get motor => _motor;

  setMotorSelected(String motor) {
    _motor = motor;
    notifyListeners();
  }
}
