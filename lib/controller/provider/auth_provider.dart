import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> signUp(String name, String email, String password) async {
    final user = await _authService.signUp(name, email, password);

    if (user != null) {
      Fluttertoast.showToast(
          msg: "Sign Up Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return true;
    } else {
      _errorMessage = 'Sign Up Failed';
      notifyListeners();
      Fluttertoast.showToast(
          msg: _errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }
  }


  Future<bool> signIn(String email, String password) async {
    final user = await _authService.signIn(email, password);

    if (user != null) {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      _errorMessage = 'Login Failed';
      notifyListeners();
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
