import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

enum AuthState { none, loading, error }

class AuthStateProvider extends ChangeNotifier {
  final auth = AuthService();

  AuthState _authState = AuthState.none;
  AuthState get viewState => _authState;

  changeState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      changeState(AuthState.loading);
      final isSuccess = await auth.login(email, password);
      if (isSuccess) {
        changeState(AuthState.none);
      }
    } catch (e) {
      changeState(AuthState.error);
    }
  }

  Future<String?> signUp(UserApp userApp) async {
    try {
      changeState(AuthState.loading);
      final isSuccess = await auth.signUp(userApp);
      if (isSuccess == 'Success') {
        changeState(AuthState.none);
        return isSuccess;
      }
      return null;
    } catch (e) {
      changeState(AuthState.error);
      return e.toString();
    }
  }
}
