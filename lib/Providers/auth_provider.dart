import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _email = '';
  String _name = 'User';
  String _profileImage = '';

  bool get isAuthenticated => _isAuthenticated;
  String get email => _email;
  String get name => _name;
  String get profileImage => _profileImage;

  void login(String email, String password) {
    // Simple authentication (just for demo)
    _isAuthenticated = true;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _email = '';
    notifyListeners();
  }

  void updateProfile({String? name, String? profileImage}) {
    if (name != null) _name = name;
    if (profileImage != null) _profileImage = profileImage;
    notifyListeners();
  }
}
