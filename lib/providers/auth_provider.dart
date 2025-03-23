import 'package:flutter/material.dart';
import 'package:hci/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuthStatus() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');

      if (userJson != null) {
        _user = UserModel.fromJson(json.decode(userJson));
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _user = null;
      }
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      // Simplified for testing - always succeeds
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock user data for demo
      final user = UserModel(
        id: 'user123',
        name: 'Rahul Wasti',
        email: email,
        profileImage: null, // No profile image for simplicity
      );

      _user = user;
      _isAuthenticated = true;

      // Save user to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(user.toJson()));

      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    _setLoading(true);
    try {
      // Simplified for testing - always succeeds
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock user creation for demo
      final user = UserModel(
        id: 'user123',
        name: name,
        email: email,
        profileImage: null, // No profile image for simplicity
      );

      _user = user;
      _isAuthenticated = true;

      // Save user to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(user.toJson()));

      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProfile(
      {String? name,
      String? phoneNumber,
      String? gender,
      String? profileImage}) async {
    if (_user == null) return false;

    _setLoading(true);
    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));

      final updatedUser = _user!.copyWith(
        name: name,
        phoneNumber: phoneNumber,
        gender: gender,
        profileImage: profileImage,
      );

      _user = updatedUser;

      // Update user in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(updatedUser.toJson()));

      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signOut() async {
    _setLoading(true);
    try {
      // Clear user data from shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');

      _user = null;
      _isAuthenticated = false;

      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
