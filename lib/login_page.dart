import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otimizador_academico/create_account.dart';
import 'package:otimizador_academico/home_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function(bool) setDarkMode;
  final bool darkMode;
  const LoginPage({Key? key, required this.setDarkMode, required this.darkMode})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen(
              setDarkMode: widget.setDarkMode,
              darkMode: widget.darkMode,
            );
          }
          return Center(child: Text('Carregando...'));
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final void Function(bool) setDarkMode;
  final bool darkMode;
  const LoginScreen(
      {Key? key, required this.setDarkMode, required this.darkMode})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  dynamic a = 'a';
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  bool tryingLogin = false;
  late bool darkMode;

  @override
  initState() {
    super.initState();
    darkMode = widget.darkMode;
  }

  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      authService.storeTokenAndData(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Usu??rio n??o encontrado.");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(60),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.darkMode == false
                            ? new Image.asset('assets/images/logo.png',
                                width: 150.0, height: 150.0)
                            : new Image.asset('assets/images/logo3-invert.png',
                                width: 150.0, height: 150.0),
                        Text(
                          'Otimizador Acad??mico',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: darkMode == true
                                  ? Colors.white
                                  // : Color(0xFF3b3b3b)
                                  : Color(0xFF2196F3),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo n??o preenchido!';
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                                color: a == 'vazio'
                                    ? Colors.red[800]
                                    : a == 'n??o existe'
                                        ? Colors.red[800]
                                        : Colors.blue),
                            focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: a == 'n??o existe'
                                        ? Color(0xFFC62828)
                                        : a == 'vazio'
                                            ? Color(0xFFC62828)
                                            : Colors.blue,
                                    width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: a == 'n??o existe'
                                      ? Color(0xFFC62828)
                                      : Colors.grey,
                                  width: 1.0),
                            ),
                            suffixIcon: (a == 'n??o existe' || a == 'vazio')
                                ? Icon(
                                    Icons.error,
                                    color: a == 'n??o existe' || a == 'vazio'
                                        ? Colors.red[800]
                                        : null,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo n??o preenchido!';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            errorText:
                                a == 'n??o existe' ? 'Dados incorretos!' : null,
                            border: OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                                color: a == 'vazio'
                                    ? Colors.red[800]
                                    : a == 'n??o existe'
                                        ? Colors.red[800]
                                        : Colors.blue),
                            focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: a == 'n??o existe'
                                        ? Color(0xFFC62828)
                                        : a == 'vazio'
                                            ? Color(0xFFC62828)
                                            : Colors.blue,
                                    width: 2.0)),
                            suffixIcon: (a == 'n??o existe' || a == 'vazio')
                                ? Icon(
                                    Icons.error,
                                    color: a == 'n??o existe' || a == 'vazio'
                                        ? Colors.red[800]
                                        : null,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.fromLTRB(
                                              0, 20, 0, 20)),
                                      backgroundColor: tryingLogin == false
                                          ? MaterialStateProperty.all(
                                              Colors.blue)
                                          : MaterialStateProperty.all(
                                              Colors.grey),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      overlayColor: MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 107, 185, 248))),
                                  child: Text(
                                    tryingLogin == false
                                        ? 'ENTRAR'
                                        : 'CARREGANDO...',
                                    style: TextStyle(
                                        letterSpacing: 1, color: Colors.white),
                                  ),
                                  onPressed: tryingLogin == true
                                      ? null
                                      : () async {
                                          setState(() {
                                            tryingLogin = true;
                                            a = 'a';
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            User? user =
                                                await loginUsingEmailPassword(
                                                    email: _emailController.text
                                                        .trim(),
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    context: context);

                                            if (user != null) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              setDarkMode:
                                                                  widget
                                                                      .setDarkMode,
                                                              darkMode: widget
                                                                  .darkMode,
                                                              uid: user.uid)));
                                            } else {
                                              setState(() {
                                                a = 'n??o existe';
                                                tryingLogin = false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              a = 'vazio';
                                              tryingLogin = false;
                                            });
                                          }
                                        }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.fromLTRB(
                                              0, 20, 0, 20)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid))),
                                  child: Text(
                                    'CRIAR CONTA',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: darkMode == true
                                            ? Colors.white
                                            : Colors.blue),
                                  ),
                                  onPressed: tryingLogin == true
                                      ? null
                                      : () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateAccount(
                                                        setDarkMode:
                                                            widget.setDarkMode,
                                                        darkMode:
                                                            widget.darkMode,
                                                      )));
                                        }),
                            ),
                          ],
                        ),
                      ]),
                ))));
  }
}
