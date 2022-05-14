import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otimizador_academico/home_page.dart';
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

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class _LoginPageState extends State<LoginPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Otimizador Acadêmico'),
      // ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen(
              setDarkMode: widget.setDarkMode,
              darkMode: widget.darkMode,
            );
          }
          return Center(child: Text('Carregando...')
              // CircularProgressIndicator(),
              );
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

  // void getTheme() async {
  //   String? theme = await authService.getTheme();
  //   if (theme == null) {
  //     authService.setThemeMode('light');
  //     setState(() {
  //       darkMode = false;
  //     });
  //   } else if (theme == 'dark') {
  //     setState(() {
  //       darkMode = true;
  //     });
  //   } else if (theme == 'light') {
  //     setState(() {
  //       darkMode = false;
  //     });
  //   }
  //   print('tema');
  //   print(theme);
  // }

  // void signUp(String email, String password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(email: email, password: password)
  //   } catch (e) {
  //     print(e);
  //   }
  // }

// static
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
        print("Usuário não encontrado.");
      }
    }

    return user;
  }

  // Future<void> storeTokenAndData(UserCredential userCredential) async {
  //   await storage.write(
  //       key: 'token', value: userCredential.credential?.token.toString());
  //   await storage.write(
  //       key: 'userCredential', value: userCredential.toString());
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    print('verificando');
    print(Theme.of(context).colorScheme.onPrimary);

    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(60),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.darkMode == false
                            ? new Image.asset('assets/images/logo3.png',
                                width: 150.0, height: 150.0)
                            : new Image.asset('assets/images/logo3-invert.png',
                                width: 150.0, height: 150.0),

                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          'Otimizador Acadêmico',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: darkMode == true
                                  ? Colors.white
                                  : Color(0xFF3b3b3b),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),

                        // Text(
                        //   'ENTRAR',
                        //   style: TextStyle(
                        //       letterSpacing: 1,
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold),
                        // ),

                        SizedBox(
                          height: 70,
                        ),

                        // Image.asset('assets/images/logo2.png'),
                        // const Text('ENTRAR',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //         letterSpacing: 1)),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextField(
                        //     controller: _emailController,
                        //     keyboardType: TextInputType.emailAddress,
                        //     decoration: const InputDecoration(
                        //         hintText: 'E-mail',
                        //         prefixIcon: Icon(Icons.mail, color: Colors.black))),
                        SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          // initialValue: 'Input text',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo não preenchido!';
                            }
                            return null;
                          },
                          controller: _emailController,
                          // focusNode: myFocusNode,

                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                                color: a == 'vazio'
                                    ? Colors.red[800]
                                    : a == 'não existe'
                                        ? Colors.red[800]
                                        : Colors.blue),
                            focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: a == 'não existe'
                                        ? Color(0xFFC62828)
                                        : a == 'vazio'
                                            ? Color(0xFFC62828)
                                            : Colors.blue,
                                    width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: a == 'não existe'
                                      ? Color(0xFFC62828)
                                      : Colors.grey,
                                  width: 1.0),
                            ),
                            suffixIcon: (a == 'não existe' || a == 'vazio')
                                ? Icon(
                                    Icons.error,
                                    color: a == 'não existe' || a == 'vazio'
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
                          // initialValue: 'Input text',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo não preenchido!';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            errorText:
                                a == 'não existe' ? 'Dados incorretos!' : null,
                            border: OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                                color: a == 'vazio'
                                    ? Colors.red[800]
                                    : a == 'não existe'
                                        ? Colors.red[800]
                                        : Colors.blue),
                            focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: a == 'não existe'
                                        ? Color(0xFFC62828)
                                        : a == 'vazio'
                                            ? Color(0xFFC62828)
                                            : Colors.blue,
                                    width: 2.0)),
                            suffixIcon: (a == 'não existe' || a == 'vazio')
                                ? Icon(
                                    Icons.error,
                                    color: a == 'não existe' || a == 'vazio'
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
                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                            // ScaffoldMessenger.of(context).showSnackBar(
                                            //   const SnackBar(
                                            //       content: Text('Processing Data')),
                                            // );

                                            User? user =
                                                await loginUsingEmailPassword(
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    context: context);

                                            print(user);

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(
                                                                setDarkMode: widget
                                                                    .setDarkMode,
                                                                darkMode: widget
                                                                    .darkMode,
                                                              )));
                                            } else {
                                              setState(() {
                                                a = 'não existe';
                                                tryingLogin = false;
                                                print(a);
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
                        // Text(
                        //   (a == 'não existe' ? 'Dados incorretos!' : ''),
                        //   style: TextStyle(
                        //     color: Colors.red,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 14,
                        //     // letterSpacing: 1
                        //   ),
                        // ),
                      ]),
                ))));
  }
}
