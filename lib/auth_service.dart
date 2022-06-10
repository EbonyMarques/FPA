import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user1) {
      user = (user1 == null) ? null : user1;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<String?> getDisplayName() async {
    return _auth.currentUser?.displayName;
  }

  Future<String?> getEmail() async {
    return _auth.currentUser?.email;
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: 'token',
        value: userCredential.user?.uid.toString());
    await storage.write(
        key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> cleanToken() async {
    await storage.delete(key: 'token');
  }

  Future<void> setThemeMode(String theme) async {
    await storage.delete(key: 'theme');
    await storage.write(
        key: 'theme',
        value: theme);
  }

  Future<String?> getTheme() async {
    return await storage.read(key: 'theme');
  }
}
