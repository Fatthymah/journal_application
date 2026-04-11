import 'package:flutter/material.dart';
import 'package:journal_application/auth/model/app_user.dart';
import 'package:journal_application/auth/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AppUser? user;
  bool isLoading = false;
  String? error;

  // check existing user
  void checkUser(){
    user = _authService.getCurrentUser();
    notifyListeners();
  }

  // Sign up
  Future<void> signup(String email,String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _authService.signUp(email, password);
    }catch(e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // Login
  Future<void> login(String email,String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _authService.login(email, password);
    }catch(e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();

      user = await _authService.signInWithGoogle();

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
