import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeNotifier with ChangeNotifier {
  final storage = new FlutterSecureStorage();

  // ThemeData _themeData;
  // ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    storage.read(key: 'theme').then((value) {
      print('value read from storage: ' + value.toString());
      notifyListeners();
    });
  }

  Future<void> setThemeMode(String theme) async {
    await storage.delete(key: 'theme');
    await storage.write(
        // key: 'token', value: userCredential.credential?.token.toString());
        key: 'theme',
        value: theme);
    notifyListeners();
  }

  Future<String?> getTheme() async {
    return await storage.read(key: 'theme');
  }
}
