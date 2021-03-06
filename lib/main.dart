import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_service.dart';

StreamController<bool> isLightTheme = StreamController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  bool isOpening = true;
  bool isLoading = true;
  bool themeIsLoaded = false;
  bool value = false;
  bool darkMode = false;
  dynamic token_final;

  @override
  void initState() {
    super.initState();
  }

  void setDarkMode(bool boolean) {
    setState(() {
      darkMode = boolean;
    });
  }

  void getTheme() async {
    String? theme = await authService.getTheme();
    if (theme == null) {
      authService.setThemeMode('light');
      setState(() {
        darkMode = false;
      });
    } else if (theme == 'dark') {
      setState(() {
        darkMode = true;
      });
    } else if (theme == 'light') {
      setState(() {
        darkMode = false;
      });
    }
  }

  void checkLogin() async {
    String? token = await authService.getToken();
    token_final = token;
    if (token != null) {
      setState(() {
        isLoading = false;
        value = true;
      });
    } else {
      setState(() {
        isLoading = false;
        value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isOpening) {
      checkLogin();
      isOpening = false;
    }

    if (!themeIsLoaded) {
      getTheme();
      themeIsLoaded = true;
    }

    return MaterialApp(
        darkTheme: darkMode == true ? ThemeData.dark() : null,
        home: isLoading
            ? Scaffold(
                body: Center(child: Text('Carregando...')),
              )
            : value == true
                ? HomePage(
                    setDarkMode: setDarkMode,
                    darkMode: darkMode,
                    uid: token_final)
                : LoginPage(
                    setDarkMode: setDarkMode,
                    darkMode: darkMode,
                  ));
  }
}
