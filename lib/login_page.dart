import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otimizador_academico/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
            return LoginScreen();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // User? user1;
  dynamic a = 'a';
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService authService = AuthService();

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
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Image.asset('assets/images/logo3.png',
                        width: 150.0, height: 150.0),

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
                        // errorText: _emailController.text == ''
                        //     ? 'Preenchimento obrigatório'
                        //     : null,
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(
                            color: a == 'vazio'
                                ? Colors.red[800]
                                : a == 'não existe'
                                    ? Colors.red[800]
                                    : Colors.blue),

                        // hintStyle: TextStyle(
                        //     color: a == 'não existe' ? Colors.red : Colors.blue),
                        // labelStyle: TextStyle(
                        //     color:
                        //          myFocusNode.hasFocus ? Colors.blue : Colors.grey),
                        focusedBorder: new OutlineInputBorder(
                            // borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: a == 'não existe'
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
                        // suffixIconColor: a == 'não existe' ? ,
                        border: OutlineInputBorder(),
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
                    // TextFormField(
                    //   cursorColor: Theme.of(context).cursorColor,
                    //   // initialValue: 'Input text',
                    //   // maxLength: 20,
                    //   decoration: InputDecoration(
                    //     icon: Icon(Icons.mail),
                    //     labelText: 'E-mail',
                    //     labelStyle: TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     // helperText: 'Helper text',
                    //     // suffixIcon: Icon(
                    //     //   Icons.check_circle,
                    //     // ),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    // TextField(
                    //   controller: _passwordController,
                    //   obscureText: true,
                    //   decoration: const InputDecoration(
                    //       hintText: 'Senha',
                    //       prefixIcon: Icon(Icons.password, color: Colors.black)),
                    // ),
                    SizedBox(
                      height: 20,
                    ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  overlayColor: MaterialStateProperty.all(
                                      const Color.fromARGB(
                                          255, 107, 185, 248))),
                              child: const Text(
                                'ENTRAR',
                                style: TextStyle(
                                    letterSpacing: 1, color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Processing Data')),
                                  // );

                                  User? user = await loginUsingEmailPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      context: context);

                                  print(user);

                                  if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  } else {
                                    setState(() {
                                      a = 'não existe';
                                      print(a);
                                    });
                                  }

                                  // if (_emailController.text != '' &&
                                  //     _passwordController.text != '') {
                                  //   User? user = await loginUsingEmailPassword(
                                  //       email: _emailController.text,
                                  //       password: _passwordController.text,
                                  //       context: context);

                                  //   print(user);

                                  //   if (user != null) {
                                  //     Navigator.of(context).pushReplacement(
                                  //         MaterialPageRoute(
                                  //             builder: (context) => HomePage()));
                                  //   } else {
                                  //     setState(() {
                                  //       a = 'não existe';
                                  //       print(a);
                                  //     });
                                  //   }
                                  // } else {
                                  //   print('ahhaha');
                                  //   setState(() {
                                  //     a = 'vazio';
                                  //     print(a);
                                  //   });
                                  // }

                                  // setState(() {
                                  //   print(result);
                                  //   selectedClasses = result;
                                  // });
                                } else {
                                  setState(() {
                                    a = 'vazio';
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
            )));
  }
}
