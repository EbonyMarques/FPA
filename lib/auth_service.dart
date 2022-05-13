import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        // key: 'token', value: userCredential.credential?.token.toString());
        key: 'token',
        value: userCredential.user?.uid.toString());
    await storage.write(
        key: 'userCredential', value: userCredential.toString());

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? value = userCredential.user?.uid;
    // sharedPreferences.setString('token', value == null ? 'null' : value);

    print('salvo!');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var token = sharedPreferences.getString('token');
  }

  Future<void> cleanToken() async {
    await storage.delete(key: 'token');
  }
}
