import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otimizador_academico/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class CreateAccount extends StatefulWidget {
  final void Function(bool) setDarkMode;
  final bool darkMode;

  const CreateAccount(
      {Key? key, required this.setDarkMode, required this.darkMode})
      : super(key: key);

  // final void Function(bool) setDarkMode = print;
  // final bool darkMode = true;

  // const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  AuthService authService = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  late bool darkMode;
  final _createAccountFormKey = GlobalKey<FormState>();
  String result = 'a';
  bool tryingCreate = false;

  @override
  initState() {
    super.initState();
    darkMode = widget.darkMode;
  }

  Future<dynamic> createAccount(
      {required String email,
      required String password,
      required BuildContext context}) async {
    dynamic result;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      result = credential.user;
      authService.storeTokenAndData(credential);
    } on FirebaseAuthException catch (e) {
      print('olha o problema!');
      print(e);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        result = 'Senha';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        result = 'Cadastro';
      } else if (e.code == 'invalid-email') {
        print('The email address is badly formatted.');
        result = 'Formato';
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(60),
                    child: Form(
                      key: _createAccountFormKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.darkMode == false
                                ? new Image.asset('assets/images/logo.png',
                                    width: 150.0, height: 150.0)
                                : new Image.asset(
                                    'assets/images/logo3-invert.png',
                                    width: 150.0,
                                    height: 150.0),
                            Text(
                              'Otimizador Acadêmico',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: darkMode == true
                                      ? Colors.white
                                      // : Color(0xFF3b3b3b)
                                      : Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text('$result'),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo não preenchido!';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(),
                                floatingLabelStyle: TextStyle(
                                    color: result == 'vazio' ||
                                            result == 'senha' ||
                                            result == 'formato'
                                        ? Colors.red[800]
                                        : result == 'existe'
                                            ? Colors.red[800]
                                            : Colors.blue),
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: result == 'existe' ||
                                                result == 'senha' ||
                                                result == 'formato'
                                            ? Color(0xFFC62828)
                                            : result == 'vazio'
                                                ? Color(0xFFC62828)
                                                : Colors.blue,
                                        width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: result == 'existe' ||
                                              result == 'senha' ||
                                              result == 'formato'
                                          ? Color(0xFFC62828)
                                          : Colors.grey,
                                      width: 1.0),
                                ),
                                suffixIcon: (result == 'existe' ||
                                        result == 'vazio' ||
                                        result == 'formato')
                                    ? Icon(
                                        Icons.error,
                                        color: result == 'existe' ||
                                                result == 'vazio' ||
                                                result == 'formato'
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
                                  return 'Campo não preenchido!';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                errorText: result == 'existe'
                                    ? 'E-mail associado à conta existente!'
                                    : result == 'senha'
                                        ? 'Senha fraca!'
                                        : result == 'formato'
                                            ? 'Verifique o e-mail digitado!'
                                            : null,
                                border: OutlineInputBorder(),
                                floatingLabelStyle: TextStyle(
                                    color: result == 'vazio' ||
                                            result == 'senha' ||
                                            result == 'formato'
                                        ? Colors.red[800]
                                        : result == 'existe'
                                            ? Colors.red[800]
                                            : Colors.blue),
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: result == 'existe' ||
                                                result == 'senha' ||
                                                result == 'formato'
                                            ? Color(0xFFC62828)
                                            : result == 'vazio'
                                                ? Color(0xFFC62828)
                                                : Colors.blue,
                                        width: 2.0)),
                                suffixIcon: (result == 'existe' ||
                                        result == 'vazio' ||
                                        result == 'formato')
                                    ? Icon(
                                        Icons.error,
                                        color: result == 'existe' ||
                                                result == 'vazio' ||
                                                result == 'formato'
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
                                          backgroundColor: tryingCreate == false
                                              ? MaterialStateProperty.all(
                                                  Color(0xFF2196F3))
                                              : MaterialStateProperty.all(
                                                  Colors.grey),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 107, 185, 248))),
                                      child: Text(
                                        tryingCreate == false
                                            ? 'CRIAR CONTA'
                                            : 'CARREGANDO...',
                                        style: TextStyle(
                                            letterSpacing: 1,
                                            color: Colors.white),
                                      ),
                                      onPressed: tryingCreate == true
                                          ? null
                                          : () async {
                                              setState(() {
                                                tryingCreate = true;
                                                result = 'a';
                                              });
                                              if (_createAccountFormKey
                                                  .currentState!
                                                  .validate()) {
                                                dynamic result1 =
                                                    await createAccount(
                                                        email: _emailController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text,
                                                        context: context);

                                                print(result1);
                                                if (result1 == 'Senha') {
                                                  setState(() {
                                                    result = 'senha';
                                                    tryingCreate = false;
                                                    print(result);
                                                  });
                                                } else if (result1 ==
                                                    'Cadastro') {
                                                  setState(() {
                                                    result = 'existe';
                                                    tryingCreate = false;
                                                    print(result);
                                                  });
                                                } else if (result1 ==
                                                    'Formato') {
                                                  setState(() {
                                                    result = 'formato';
                                                    tryingCreate = false;
                                                    print(result);
                                                  });
                                                } else {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(
                                                                  setDarkMode:
                                                                      widget
                                                                          .setDarkMode,
                                                                  darkMode: widget
                                                                      .darkMode,
                                                                  uid: result1
                                                                      .uid)),
                                                      (route) => false);

                                                  // Navigator.of(context)
                                                  //     .pushReplacement(
                                                  //         MaterialPageRoute(
                                                  //             builder:
                                                  //                 (context) =>
                                                  //                     HomePage(
                                                  //                       setDarkMode:
                                                  //                           widget.setDarkMode,
                                                  //                       darkMode:
                                                  //                           widget.darkMode,
                                                  //                     )));
                                                }
                                              } else {
                                                setState(() {
                                                  result = 'vazio';
                                                  tryingCreate = false;
                                                });
                                              }
                                            }),
                                ),
                              ],
                            ),
                          ]),
                    )))));
  }
}
